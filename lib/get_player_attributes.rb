require 'awesome_print'

require_relative '../requests/player_request'
require_relative '../payload_builder/player_all_combinations'

combinations = PlayerAllCombinations.combinations

combinations.each do |combination|
  ap combination
  player = PlayerRequest.new(combination["matchday"],
                             combination["season"],
                             combination["page"],
                             2)
  player.get_info
  player.get_attributes
  player.save_attributes
end
