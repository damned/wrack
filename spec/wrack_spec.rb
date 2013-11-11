require 'rspec'
require 'net/http'
require_relative 'funrun'

describe 'wrack' do

  before :all do
    @website = FunRun.new('rackup').start do
      tcp_check 8080
    end
  end

  after :all do
    @website.stop
  end

  it 'should say hello' do
    response = Net::HTTP.get_response URI('http://localhost:8080/whatever')
    expect(response.body).to include 'wrack not ruin'
  end
end
