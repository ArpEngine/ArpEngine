package arpx.nextMotion;

import arp.domain.IArpObject;
import arpx.motion.Motion;
import arpx.structs.ArpRange;

@:arpType("nextMotion", "nextMotion")
class NextMotion implements IArpObject {

	@:arpField public var motion:Motion;
	@:arpField public var action:String;
	@:arpField public var timeRange:ArpRange;

	public function new() {
	}
}


