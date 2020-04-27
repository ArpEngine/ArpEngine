package arpx.motionTween;

import arp.domain.IArpObject;
import arpx.structs.ArpPosition;

@:arpType("motionTween", "motionTween")
class MotionTween implements IArpObject {

	@:arpField public var time:Float;

	public function new() return;

	public function updatePosition(position:ArpPosition, target:ArpPosition, oldTime:Float, newTime:Float, nextTime:Float):Void {
	}
}
