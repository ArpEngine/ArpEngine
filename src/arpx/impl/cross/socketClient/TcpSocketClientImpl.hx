package arpx.impl.cross.socketClient;

#if arp_socket_backend_flash
typedef TcpSocketClientImpl = arpx.impl.flash.socketClient.TcpSocketClientImpl;
#else
typedef TcpSocketClientImpl = ISocketClientImpl;
#end
