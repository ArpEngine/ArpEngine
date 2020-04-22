package arpx.motionFrame;

import arpx.field.Field;
import arpx.mortal.Mortal;
import arpx.structs.ArpCurve;
import arpx.structs.ArpPosition;

@:arpType("motionFrame", "curve")
class CurveMotionFrame extends MotionFrame {

	@:arpField public var x:ArpCurve;
	@:arpField public var y:ArpCurve;
	@:arpField public var z:ArpCurve;
	@:arpField public var r:ArpCurve;
	@:arpField public var s:ArpCurve;

	public function new() super();

	override public function updateShadowPosition(shadow:Mortal, oldTime:Float, newTime:Float, nextTime:Float):Void {
		var t0:Float = oldTime - time;
		var t1:Float = newTime - time;
		var pos:ArpPosition = shadow.position;
		var x:Float = this.x.accumulate(t0, t1);
		var y:Float = this.y.accumulate(t0, t1);
		var z:Float = this.z.accumulate(t0, t1);
		var r:Float = this.r.accumulate(t0, t1);
		var s:Float = this.s.accumulate(t0, t1);

		pos.x += x + r * Math.cos(pos.dir.valueRadian) + s * Math.sin(pos.dir.valueRadian);
		pos.y += y + r * Math.sin(pos.dir.valueRadian) - s * Math.cos(pos.dir.valueRadian);
		pos.z += z;
	}

	override public function updateMortalPosition(field:Field, mortal:Mortal, oldTime:Float, newTime:Float, nextTime:Float, dHitType:String):Void {
		var t0:Float = oldTime - time;
		var t1:Float = newTime - time;
		var pos:ArpPosition = mortal.position;
		var x:Float = this.x.accumulate(t0, t1);
		var y:Float = this.y.accumulate(t0, t1);
		var z:Float = this.z.accumulate(t0, t1);
		var r:Float = this.r.accumulate(t0, t1);
		var s:Float = this.s.accumulate(t0, t1);

		var dPosX:Float = x + r * Math.cos(pos.dir.valueRadian) + s * Math.sin(pos.dir.valueRadian);
		var dPosY:Float = y + r * Math.sin(pos.dir.valueRadian) - s * Math.cos(pos.dir.valueRadian);
		var dPosZ:Float = z;
		mortal.hitFrames.clear();
		for (hitFrame in this.hitFrames) mortal.hitFrames.add(hitFrame);
		mortal.moveDWithHit(field, dPosX, dPosY, dPosZ, dHitType);
	}
}
