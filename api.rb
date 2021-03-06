require 'sinatra'
require 'byebug'

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

before do
  content_type 'application/json'
end

error do |e|
  content_type :text
  e.full_message.tap { |message| logger.error(message) }
end
