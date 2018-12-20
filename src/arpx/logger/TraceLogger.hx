package arpx.logger;

import arp.domain.events.ArpLogEvent;

@:arpType("logger", "trace")
class TraceLogger extends Logger {

	public function new() {
		super();
	}

	override public function log(event:ArpLogEvent):Void {
		if (!this.respondsTo(event.category)) return;
		trace("[" + event.category + "]", event.message);
	}
}


