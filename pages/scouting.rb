require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'

Capybara.default_driver = :selenium


module Scouting
  include Capybara::DSL

  def self.go_to_page
    browser = Capybara.current_session
    browser.visit 'http://gouden11.hln.be/j2ee_g11/scouts/page.action'
  end

end