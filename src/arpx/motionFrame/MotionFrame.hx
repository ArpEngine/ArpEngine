package arpx.motionFrame;

import arp.domain.IArpObject;
import arp.ds.ISet;
import arpx.hitFrame.HitFrame;
import arpx.structs.ArpParams;

@:arpType("motionFrame", "motionFrame")
class MotionFrame implements IArpObject {

	@:arpField public var params:ArpParams;
	@:arpField(true) public var hitFrames:ISet<HitFrame>;
	@:arpField public var time:Float;

	public function new() return;
}
