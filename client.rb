require 'socket'

hostname = 'localhost'
port = 2000

socket = TCPSocket.open(hostname, port)

socket.puts "Hello"

socket.close
