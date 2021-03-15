require 'sinatra'
require 'byebug'

require 'engines-logger'

require './api/universe'
require './api/arenas'
require './api/metrics'
require './api/packing'
require './api/provisioning'
require './api/resolutions'
require './api/system'
require './api/import'
require './api/crud'

set show_exceptions: false

class Rack::Builder
  include ::Engines::Logger
end

def incoming_request(env)
  "#{env['rack.url_scheme']}://#{env['HTTP_HOST']}#{env['REQUEST_URI']}"
end

before do
  logger.info("Starting route: #{incoming_request(request.env)}")
  content_type 'application/json'
end

error do |e|
  content_type :text
  e.full_message.tap { |message| logger.error(message) }
end
