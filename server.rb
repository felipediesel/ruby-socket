require 'socket'

port = 2000
server = TCPServer.open port
puts "Starting server at localhost: #{port}"

loop do # Server runs forever
  Thread.start server.accept do |client| # Wait for a client to connect
    loop do
      data = client.gets

      break if data.nil?

      puts "Client sent: '#{data.chomp}'"
    end

    puts "Client closed connection."
    client.close
  end
end

server.close
