require_relative './pages'

module Scouting

  include Pages

  def self.go_to_page
    BROWSER.visit 'j2ee_g11/scouts/page.action'
  end



end