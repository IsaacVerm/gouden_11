require 'nokogiri'
require 'rest-client'

require 'awesome_print'

class Player

  PLAYER_VALUES_XPATH_IND = {"price" => "4",
                             "goal" => "5",
                             "assist" => "6",
                             "yellow" => "7",
                             "red" => "8",
                             "clean_sheet" => "9",
                             "goal_conceded" => "10",
                             "half_time" => "11",
                             "team_performance" => "12"}

  PLAYER_URL = 'http://gouden11.hln.be/j2ee_g11/scouts/table.action'

  NAMES_XPATH = "//table[@class='playerlist']/tbody/tr/td/a"
  TEAMS_POS_XPATH = "//table[@class='playerlist']/tbody/tr/td/span"

  def initialize(payload)
    @payload = payload
  end

  def response_to_html(response)
    Nokogiri::HTML(response)
  end

  def get_info
    @response = RestClient.post PLAYER_URL,
                                @payload,
                                {content_type: :'application/x-www-form-urlencoded'}

    @html = response_to_html(@response)
  end

  def text(nodes)
    nodes.map{ |node| node.text }
  end

  def get_names
    text(@html.xpath(NAMES_XPATH))
  end

  def get_teams
    @html.xpath(TEAMS_POS_XPATH).map do |element|
      element.text.split('-').first.rstrip
    end
  end

  def get_positions
    @html.xpath(TEAMS_POS_XPATH).map do |element|
      element.text.split('-').last.strip
    end
  end

  def get_attribute(attribute)
    ind = PLAYER_VALUES_XPATH_IND[attribute]

    text(@html.xpath("//table[@class='playerlist']/tbody/tr/td[#{ind}]"))
  end

  def get_attributes_as_hash_of_arrays
    attributes = Hash.new

    attributes["name"] = get_names
    attributes["team"] = get_teams

    PLAYER_VALUES_XPATH_IND.keys.each do |attribute|
      attributes[attribute] = get_attribute(attribute)
    end

    return attributes
  end

  def attributes_to_array_of_hashes(attributes_hash)
    attributes_array = Array.new

    array_length = attributes_hash["name"].size # they're all the same length
    player_ind = 0..(array_length - 1)

    player_ind.each do |i|
      player_hash = Hash.new
      attributes = attributes_hash.keys

      attributes.each do |attribute|
        player_hash[attribute] = attributes_hash[attribute][i]
      end

      attributes_array << player_hash
    end

    return attributes_array
  end

  def get_attributes
    attributes_hash = get_attributes_as_hash_of_arrays
    attributes = attributes_to_array_of_hashes(attributes_hash)

    return attributes
  end

  def save_attributes

  end

end