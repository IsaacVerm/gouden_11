# ui
# require_relative '../pages/../pages/scouting'
# Scouting.go_to_page

# api
require 'awesome_print'

require_relative '../requests/player_request'

# single
player = PlayerRequest.new('3', '2017-2018', '5')
player.get_info
player.get_attributes
player.save_attributes

# all


# matchday_page.zip do |matchday, page|
#   player = PlayerRequest.new(PlayerPayloadBuilder.payload(matchday, page))
#   player.get_info
#   player.get_attributes
#   player.save_attributes
# end
