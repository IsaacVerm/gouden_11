require 'capybara/dsl'
require 'selenium-webdriver'

Capybara.default_driver = :selenium
Capybara.app_host = 'http://gouden11.hln.be/'

module Pages
  BROWSER = Capybara.current_session

  include Capybara::DSL
end