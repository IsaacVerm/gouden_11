class PlayerPayloadBuilder

  def initialize
    number_of_pages = #Capybara
    MATCHDAY_IDS = [-1, *394..414]
  end



  def payload(matchday, page)
    'filter.minPlayerValue=&filter.maxPlayerValue=&filter.playerLastName=&order=&matchdayId=' +
    matchday +
    '&page=' +
    page
  end

  def payload_by_matchday

  end

end