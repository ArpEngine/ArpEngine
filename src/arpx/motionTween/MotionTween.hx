package arpx.motionTween;

import arp.domain.IArpObject;
import arp.ds.ISet;
import arpx.hitFrame.HitFrame;
import arpx.structs.ArpPosition;

@:arpType("motionTween", "motionTween")
class MotionTween implements IArpObject {

	@:arpField(true) public var hitFrames:ISet<HitFrame>;
	@:arpField public var time:Float;

	public function new() return;

	public function updateShadowPosition(position:ArpPosition, target:ArpPosition, oldTime:Float, newTime:Float, nextTime:Float):Void {
	}
}
