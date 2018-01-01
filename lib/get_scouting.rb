# ui
# require_relative '../pages/../pages/scouting'
# Scouting.go_to_page

# api
require 'rest-client'

require_relative '../payload_builder/player_payload_builder'
require_relative '../requests/player'

player = Player.new(PlayerPayloadBuilder.payload('412','2'))
player.get_info
player.extract_attributes
player.save_attributes
