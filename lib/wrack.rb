require 'rack'
require 'rack/server'

module Wrack
  def self.app
    proc do |env|
      [200, { 'Content-Type' => 'text/html' }, '<html><body>wrack not ruin</body</html>']
    end
  end
end
