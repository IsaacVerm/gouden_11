require_relative '../pages/scouting'
require_relative '../models/player'

module PlayerAllCombinations

  extend Scouting

  def self.get_matchdays
    matchdays = (1..Player::LAST_MATCHDAY).to_a
    matchdays << "previous season"

    return matchdays
  end

  def self.get_pages
    Scouting.go_to_page
    Scouting.get_more(25)
    number_of_pages = Scouting.get_number_of_pages.to_i

    (1..number_of_pages).to_a
  end

  def self.combinations
    matchdays = get_matchdays
    pages = get_pages

    combinations = Array.new
    matchdays.each do |matchday|
      pages.each do |page|
        if matchday == "previous season"
          season = "2016-2017"
        else
          season = "2017-2018"
        end

        combinations << {"matchday" => matchday.to_s,
                         "season" => season,
                         "page" => page.to_s}
      end
    end

    return combinations
  end

end