package arpx.logger;

import arp.domain.events.ArpLogEvent;
import arp.domain.IArpObject;

@:arpType("logger", "null")
class Logger implements IArpObject {

	@:arpField("categories", "category") public var categories:Array<String>;

	public function new() {
	}

	@:arpHeatUp private function heatUp():Bool {
		this.arpDomain.onLog.push(this.log);
		return true;
	}

	@:arpHeatDown private function heatDown():Bool {
		this.arpDomain.onLog.remove(this.log);
		return true;
	}

	public function log(event:ArpLogEvent):Void {
	}

	public function respondsTo(category:String):Bool {
		return category == "*" || this.categories.indexOf(category) >= 0 || this.categories.indexOf("*") >= 0;
	}
}


