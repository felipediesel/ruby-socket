require 'socket'

port = 2000
server = TCPServer.open port
puts "Starting server at localhost: #{2000}"

loop do # Servers run forever
  client = server.accept # Wait for a client to connect

  data = client.recvfrom(1024)[0].chomp
  puts "Client send: '#{data}'"

  client.close
end
