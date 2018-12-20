package arpx.socketClient;

import arpx.impl.cross.socketClient.TcpCachedSocketClientImpl;

@:arpType("socketClient", "tcpCached")
class TcpCachedSocketClient extends SocketClient {

	@:arpField public var host:String;

	@:arpImpl private var arpImpl:TcpCachedSocketClientImpl;

	public function new() super();
}


