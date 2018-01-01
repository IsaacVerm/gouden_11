module PlayerPayloadBuilder

  def self.payload(matchday, page)
    'filter.minPlayerValue=&filter.maxPlayerValue=&filter.playerLastName=&order=&matchdayId=' +
    matchday +
    '&page=' +
    page
  end

end