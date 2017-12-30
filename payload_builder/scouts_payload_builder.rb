class ScoutsPayloadBuilder

  attr_accessor :payload

  # 25 players per page
  def initialize(matchday, page)
    @matchday = matchday
    @page = page
  end

  def create_payload
    @payload = 'filter.minPlayerValue=&filter.maxPlayerValue=&filter.playerLastName=&order=&matchdayId=' +
                @matchday +
                '&page=' +
                @page
  end

end