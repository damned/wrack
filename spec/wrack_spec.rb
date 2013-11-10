require 'rspec'
require 'net/http'
require 'socket'

describe 'wrack' do

  def server_up
    begin
      print 'connecting...'
      TCPSocket.new('localhost', 8080).close
      puts 'ok'
      true
    rescue
      puts 'barf!'
      false
    end
  end

  before :all do
    @website = Kernel.spawn 'rackup'
    until server_up do
      sleep 0.2
    end
    puts "spawned website pid: #{@website}"
  end

  after :all do
    puts "killing website pid: #{@website}"
    Process.kill 'KILL', @website
    puts "waiting for website pid: #{@website}"
    Process.wait @website
    puts "waited for website pid: #{@website}"
  end

  it 'should say hello' do
    response = Net::HTTP.get_response URI('http://localhost:8080/whatever')
    expect(response.body).to include 'wrack not ruin'
  end
end
