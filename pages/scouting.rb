require_relative './pages'

module Scouting

  include Pages

  NUMBER_OF_PLAYERS = ""

  def self.go_to_page
    BROWSER.visit 'j2ee_g11/scouts/page.action'
  end

  def self.get_number_of_pages
    raw_number_of_players = BROWSER.find(:xpath, NUMBER_OF_PLAYERS).text

    number_of_players = Hash.new
    total = ""
    by_page = ""

    total/by_page
  end

end