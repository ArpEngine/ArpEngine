package arpx.impl.cross.socketClient;

#if arp_socket_backend_flash
typedef TcpCachedSocketClientImpl = arpx.impl.flash.socketClient.TcpCachedSocketClientImpl;
#else
typedef TcpCachedSocketClientImpl = ISocketClientImpl;
#end
