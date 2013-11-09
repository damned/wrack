require 'rspec'
require 'net/http'

describe 'wrack' do

  before :all do
    @website = Kernel.fork do
      `rackup`
    end
  end

  after :all do
    Process.kill 'TERM', @website
    Process.wait @website
  end

  it 'should say hello' do
    response = Net::HTTP.get_response URI('http://localhost:8080/whatever')
    expect(response.body).to include 'wrack not ruin'
  end
end
