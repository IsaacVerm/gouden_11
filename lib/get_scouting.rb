# ui
# require_relative '../pages/../pages/scouting'
# Scouting.go_to_page

# api
require 'rest-client'

require_relative '../payload_builder/scouts_payload_builder'
require_relative '../requests/scouts'

payload_builder = ScoutsPayloadBuilder.new('412', '2')
payload_builder.create_payload
payload = payload_builder.payload

puts Scouts.post(payload)
