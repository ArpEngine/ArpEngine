package arpx.socketClient;

import arpx.impl.cross.socketClient.TcpSocketClientImpl;

@:arpType("socketClient", "tcp")
class TcpSocketClient extends SocketClient {

	@:arpField public var host:String;

	@:arpImpl private var arpImpl:TcpSocketClientImpl;

	public function new() super();
}


