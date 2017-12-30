# ui
# require_relative '../pages/../pages/scouting'
# Scouting.go_to_page

# api
require 'rest-client'

require_relative '../payload_builder/scouts_payload_builder'
require_relative '../requests/scouts'

scouts = Scouts.new(ScoutsPayloadBuilder.payload('412','2'))
scouts.post
scouts.response_to_html
scouts.info_by_player