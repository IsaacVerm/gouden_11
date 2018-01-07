require_relative '../models/player'

class PlayerPayloadBuilder

  # matchdays go from 1 to 30, -1 is the summary of the previous season
  def initialize(matchday, page)
    @matchday = matchday
    @page = page

    @matchday_ids = Hash.new

    [-2, *Player::FIRST_MATCHDAY_ID..Player::LAST_MATCHDAY_ID].zip(["previous season", *1..Player::LAST_MATCHDAY]) do |id, matchday|
      @matchday_ids[matchday.to_s] = id.to_s
    end

  end

  def payload
    'filter.minPlayerValue=&filter.maxPlayerValue=&filter.playerLastName=&order=&matchdayId=' +
    @matchday_ids[@matchday] +
    '&page=' +
    @page
  end

end