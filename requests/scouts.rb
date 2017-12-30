require 'nokogiri'
require 'awesome_print'

class Scouts

  def initialize(payload)
    @payload = payload
  end

  def post
    @response = RestClient.post 'http://gouden11.hln.be/j2ee_g11/scouts/table.action',
                                @payload,
                                {content_type: :'application/x-www-form-urlencoded'}
  end

  def response_to_html
    @html = Nokogiri::HTML(@response)
  end

  def info_by_player
    player_nodes = @html.xpath("//table[@class='playerlist']/tbody/tr")

    @info_by_player = player_nodes.map do |node|
      node.xpath("//td").map{ |element| element.text }
    end

    ap @info_by_player
  end

  def save_to_database
    # @info_by_player.add_to_sql
  end

end