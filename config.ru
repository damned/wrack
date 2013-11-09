require './lib/wrack'
Rack::Server.start :app => Wrack.app
