require 'rspec'
require 'net/http'
require 'socket'

class FunRun
  def initialize(command)
    @command = command
    @output = StringIO.new
  end
  def start(options={}, &started_check)
    check_period = options[:check_period] || 0.1
    output = options[:output] || @output

    output.print 'starting...'
    @pid = Kernel.spawn(@command)
    if started_check
      until call(&started_check) do
        output.print '.'
        sleep check_period
      end
    end
    output.puts "ok (#{@pid})"
    self
  end
  def stop
    Process.kill 'KILL', @pid
    Process.wait @pid
  end
  def tcp_check(port)
    TCPSocket.new('localhost', port).close
    true
  end
  private
  def call(&block)
    begin
      instance_eval(&block)
    rescue
      false
    end
  end
end

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
