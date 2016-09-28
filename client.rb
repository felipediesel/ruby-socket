require 'socket'

hostname = 'localhost'
port = 2000

socket = TCPSocket.open(hostname, port)

loop do
  print "> "
  data = gets

  break if data.nil? || data.chomp == 'exit'

  socket.puts data.chomp
end

puts "\nGoodbye..."
socket.close
