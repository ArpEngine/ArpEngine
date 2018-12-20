package arpx.impl.stub.socketClient;

#if (arp_socket_backend_stub || arp_backend_display)

import arpx.impl.cross.socketClient.SocketClientNullImpl;
import arpx.socketClient.TcpSocketClient;

class TcpSocketClientImpl extends SocketClientNullImpl {

	private var socketClient:TcpSocketClient;

	public function new(socketClient:TcpSocketClient) {
		super();
		this.socketClient = socketClient;
	}
}

#end
