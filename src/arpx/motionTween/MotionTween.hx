package arpx.motionTween;

import arpx.structs.ArpRange;
import arp.domain.IArpObject;
import arpx.structs.ArpPosition;

@:arpType("motionTween", "motionTween")
class MotionTween implements IArpObject {

	@:arpField public var time:ArpRange;

	public function new() return;

	public function updatePosition(position:ArpPosition, target:ArpPosition, oldTime:Float, newTime:Float):Void {
	}
}
