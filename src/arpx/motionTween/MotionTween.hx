package arpx.motionTween;

import arp.domain.IArpObject;
import arp.ds.ISet;
import arpx.field.Field;
import arpx.hitFrame.HitFrame;
import arpx.mortal.Mortal;
import arpx.structs.ArpPosition;

@:arpType("motionTween", "motionTween")
class MotionTween implements IArpObject {

	@:arpField(true) public var hitFrames:ISet<HitFrame>;
	@:arpField public var time:Float;

	public function new() return;

	public function updateShadowPosition(shadow:Mortal, target:ArpPosition, oldTime:Float, newTime:Float, nextTime:Float):Void {
	}

	public function updateMortalPosition(field:Field, mortal:Mortal, target:ArpPosition, oldTime:Float, newTime:Float, nextTime:Float, dHitType:String):Void {
		mortal.stayWithHit(field, dHitType);
	}
}
