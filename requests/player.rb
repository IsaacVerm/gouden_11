require 'nokogiri'
require 'awesome_print'
require 'sequel'

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

  def get_player_values(value_name)
    ind = PLAYER_VALUES_XPATH_IND[value_name]

    text(@html.xpath("//table[@class='playerlist']/tbody/tr/td[#{ind}]"))
  end

  def extract_attributes
    @attributes = Array.new

    names = get_names
    teams = get_teams
    positions = get_positions
    prices = get_player_values("price")
    goals = get_player_values("goal")
    assists = get_player_values("assist")
    yellows = get_player_values("yellow")
    reds = get_player_values("red")
    clean_sheets = get_player_values("clean_sheet")
    goals_conceded = get_player_values("goal_conceded")
    half_times = get_player_values("half_time")
    team_performances = get_player_values("team_performance")

    # very ugly, refactor
    names.zip(teams,
              positions,
              prices,
              goals,
              assists,
              yellows,
              reds,
              clean_sheets,
              goals_conceded,
              half_times,
              team_performances) do |name, team, position, price, goal, assist, yellow, red, clean_sheet, goal_conceded, half_time, team_performance|
      @attributes.push Hash.new
      @attributes.last[:name] = name
      @attributes.last[:team] = team
      @attributes.last[:position] = position
      @attributes.last[:price] = price
      @attributes.last[:goal] = goal
      @attributes.last[:assist] = assist
      @attributes.last[:yellow] = yellow
      @attributes.last[:red] = red
      @attributes.last[:clean_sheet] = clean_sheet
      @attributes.last[:goal_conceded] = goal_conceded
      @attributes.last[:half_time] = half_time
      @attributes.last[:team_performance] = team_performance
    end

    @attributes
  end

  def save_attributes
    player = Sequel.sqlite('player.db')

    # player.create_table :attributes do
    #   primary_key :id
    #   String :name
    #   String :team
    #   String :position
    #   Float :price
    #   Float :goal
    #   Float :assist
    #   Float :yellow
    #   Float :red
    #   Float :clean_sheet
    #   Float :goal_conceded
    #   Float :half_time
    #   Float :team_performance
    # end

    attributes = player[:attributes]

    @attributes.each do |attributes_player|
      attributes.insert(attributes_player)
    end

  end
end