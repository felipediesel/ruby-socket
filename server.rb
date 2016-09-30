require 'socket'

class Logger
  def initialize(path, stdout = true)
    @path = path
    @stdout = stdout
  end

  def write(message, client = nil)
    client_req = client.nil? ? '' : client.peeraddr[1]
    status = (client.nil? || client.closed?) ? 'closed' : 'connected'

    message = "#{Time.now}; #{client_req}; #{status}; #{message}\n"
    File.open @path, "a+" do |f|
      f.write message
    end

    print message if @stdout
  end
end

class Server
  def initialize(port)
    @logger = Logger.new('messages.log')

    @port = port
    @server = TCPServer.open port
    @logger.write "Starting server at localhost: #{port}"

    run

    @server.close
  end

  def run
    loop do # Server runs forever
      Thread.start @server.accept do |client| # Wait for a client to connect
        listen client
      end
    end
  end

  def listen(client)
    @logger.write "New client", client
    loop do
      data = client.gets

      break if data.nil?

      @logger.write data.chomp, client
    end

    @logger.write  "Client closed connection.", client
    client.close
  end
end

Server.new 2000
