# ui
# require_relative '../pages/../pages/scouting'
# Scouting.go_to_page

# api
require 'awesome_print'

require_relative '../payload_builder/player_payload_builder'
require_relative '../requests/player_request'

player = PlayerRequest.new(PlayerPayloadBuilder.payload('412','2'))
player.get_info
player.get_attributes
player.save_attributes
