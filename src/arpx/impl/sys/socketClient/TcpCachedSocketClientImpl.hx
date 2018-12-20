package arpx.impl.sys.socketClient;

#if (arp_socket_backend_sys || arp_backend_display)

import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.socketClient.SocketClientNullImpl;
import arpx.socketClient.TcpCachedSocketClient;

class TcpCachedSocketClientImpl extends SocketClientNullImpl {

	private var socketClient:TcpCachedSocketClient;

	public function new(socketClient:TcpCachedSocketClient) {
		super();
		this.socketClient = socketClient;
	}
}

#end
