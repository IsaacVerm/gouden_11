require_relative './pages'

module Scouting

  include Pages

  MORE = "(//a[@class='arrow-right'])[1]"
  PAGES = "//li[@class='matchdayItem']"

  def self.go_to_page
    BROWSER.visit 'j2ee_g11/scouts/page.action'
  end

  def self.get_more(n)
    n.times { BROWSER.find(:xpath, MORE).click }
  end

  def self.get_number_of_pages
    BROWSER.find_all(:xpath, PAGES).last['page']
  end

end