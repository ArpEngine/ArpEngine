package arpx.logger;

import arp.domain.events.ArpLogEvent;
import arpx.socketClient.SocketClient;

@:arpType("logger", "socketClient")
class SocketClientLogger extends Logger {

	@:arpField @:arpBarrier public var socketClient:SocketClient;

	public function new() {
		super();
	}

	override private function heatUp():Bool {
		super.heatUp();
		if (this.socketClient != null) {
			this.socketClient.onClose.push(this.onClose);
		}
		return true;
	}

	private function onClose(_:Any):Void {

	}

	override public function log(event:ArpLogEvent):Void {
		if (!this.respondsTo(event.category)) return;
		try {
			this.socketClient.writeUtfBlob("[" + event.category + "]" + StringTools.replace(event.message, "\n", "\n ") + "\n");
		} catch (d:Dynamic) {
			// ignore
		}
	}
}


