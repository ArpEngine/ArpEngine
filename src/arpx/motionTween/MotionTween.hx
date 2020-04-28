package arpx.motionTween;

import arp.domain.IArpObject;
import arpx.structs.ArpParams;
import arpx.structs.ArpPosition;
import arpx.structs.ArpRange;

@:arpType("motionTween", "motionTween")
class MotionTween implements IArpObject {

	@:arpField public var time:ArpRange;

	public function new() return;

	public function update(position:ArpPosition, target:ArpPosition, params:ArpParams, oldTime:Float, newTime:Float):Void {
	}
}
