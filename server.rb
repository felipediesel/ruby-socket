require 'socket'

class Server
  def initialize(port)
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
    puts "New client"
    loop do
      data = client.gets

      break if data.nil?

      puts "Client sent: #{data.chomp}"
    end

    puts "Client closed connection."
    client.close
  end
end

Server.new 2000
