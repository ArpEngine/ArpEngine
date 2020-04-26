package arpx.motionFrame;

import arpx.field.Field;
import arpx.mortal.Mortal;
import arpx.structs.ArpCurve;
import arpx.structs.ArpPosition;

@:arpType("motionFrame", "target")
class TargetMotionFrame extends MotionFrame {

	@:arpField public var curve:ArpCurve;
	@:arpField public var position:ArpPosition;
	@:arpField public var absolute:Bool;

	public function new() super();

	override public function updateShadowPosition(shadow:Mortal, target:ArpPosition, oldTime:Float, newTime:Float, nextTime:Float):Void {
		var pos:ArpPosition = shadow.position;
		var t0:Float = oldTime - time;
		var t1:Float = newTime - time;
		var factor:Float = this.curve.accumulateByRatio(t0, t1);
		var dPosX:Float;
		var dPosY:Float;
		var dPosZ:Float;
		if (absolute) {
			dPosX = (this.position.x - pos.x) * factor;
			dPosY = (this.position.y - pos.y) * factor;
			dPosZ = (this.position.z - pos.z) * factor;
		} else {
			dPosX = (target.x - pos.x) * factor;
			dPosY = (target.y - pos.y) * factor;
			dPosZ = (target.z - pos.z) * factor;
		}
		pos.x += dPosX;
		pos.y += dPosY;
		pos.z += dPosZ;
	}

	override public function updateMortalPosition(field:Field, mortal:Mortal, target:ArpPosition, oldTime:Float, newTime:Float, nextTime:Float, dHitType:String):Void {
		var pos:ArpPosition = mortal.position;
		var t0:Float = oldTime - time;
		var t1:Float = newTime - time;
		var factor:Float = this.curve.accumulateByRatio(t0, t1);
		var dPosX:Float;
		var dPosY:Float;
		var dPosZ:Float;
		if (absolute) {
			dPosX = (this.position.x - pos.x) * factor;
			dPosY = (this.position.y - pos.y) * factor;
			dPosZ = (this.position.z - pos.z) * factor;
		} else {
			dPosX = (target.x - pos.x) * factor;
			dPosY = (target.y - pos.y) * factor;
			dPosZ = (target.z - pos.z) * factor;
		}
		mortal.hitFrames.clear();
		for (hitFrame in this.hitFrames) mortal.hitFrames.add(hitFrame);
		mortal.moveDWithHit(field, dPosX, dPosY, dPosZ, dHitType);
	}
}
