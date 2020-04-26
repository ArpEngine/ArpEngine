package arpx.motionFrame;

import arp.domain.IArpObject;
import arp.ds.ISet;
import arpx.field.Field;
import arpx.hitFrame.HitFrame;
import arpx.mortal.Mortal;
import arpx.structs.ArpParams;
import arpx.structs.ArpPosition;

@:arpType("motionFrame", "motionFrame")
class MotionFrame implements IArpObject {

	@:arpField public var params:ArpParams;
	@:arpField(true) public var hitFrames:ISet<HitFrame>;
	@:arpField public var time:Float;

	public function new() return;

	public function updateShadowPosition(shadow:Mortal, target:ArpPosition, oldTime:Float, newTime:Float, nextTime:Float):Void {
	}

	public function updateMortalPosition(field:Field, mortal:Mortal, target:ArpPosition, oldTime:Float, newTime:Float, nextTime:Float, dHitType:String):Void {
		mortal.stayWithHit(field, dHitType);
	}
}
