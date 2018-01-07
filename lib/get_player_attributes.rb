# ui
# require_relative '../pages/../pages/scouting'
# Scouting.go_to_page

# api
require 'awesome_print'

require_relative '../requests/player_request'
require_relative '../payload_builder/player_all_combinations'

# single
# player = PlayerRequest.new('3', '2017-2018', '5')
# player.get_info
# player.get_attributes
# player.save_attributes

# all
combinations = PlayerAllCombinations.combinations

combinations.each do |combination|
  ap combination
  player = PlayerRequest.new(combination["matchday"],
                             combination["season"],
                             combination["page"],
                             5)
  player.get_info
  player.get_attributes
  player.save_attributes
end
