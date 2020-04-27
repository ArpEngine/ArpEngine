package arpx.motionTween;

import arpx.field.Field;
import arpx.mortal.Mortal;
import arpx.structs.ArpCurve;
import arpx.structs.ArpPosition;

@:arpType("motionTween", "curve")
class CurveMotionTween extends MotionTween {

	@:arpField public var x:ArpCurve;
	@:arpField public var y:ArpCurve;
	@:arpField public var z:ArpCurve;
	@:arpField public var r:ArpCurve;
	@:arpField public var s:ArpCurve;
	@:arpField public var absolute:Bool = false;

	public function new() super();

	override public function updateShadowPosition(shadow:Mortal, target:ArpPosition, oldTime:Float, newTime:Float, nextTime:Float):Void {
		var pos:ArpPosition = shadow.position;
		var t0:Float = oldTime - time;
		var t1:Float = newTime - time;
		if (absolute) {
			var x:Float = this.x.interpolate(t1);
			var y:Float = this.y.interpolate(t1);
			var z:Float = this.z.interpolate(t1);

			pos.x = x;
			pos.y = y;
			pos.z = z;

		} else {
			var x:Float = this.x.accumulate(t0, t1);
			var y:Float = this.y.accumulate(t0, t1);
			var z:Float = this.z.accumulate(t0, t1);
			var r:Float = this.r.accumulate(t0, t1);
			var s:Float = this.s.accumulate(t0, t1);

			pos.x += x + r * Math.cos(pos.dir.valueRadian) + s * Math.sin(pos.dir.valueRadian);
			pos.y += y + r * Math.sin(pos.dir.valueRadian) - s * Math.cos(pos.dir.valueRadian);
			pos.z += z;
		}
	}

	override public function updateMortalPosition(field:Field, mortal:Mortal, target:ArpPosition, oldTime:Float, newTime:Float, nextTime:Float, dHitType:String):Void {
		var pos:ArpPosition = mortal.position;
		var t0:Float = oldTime - time;
		var t1:Float = newTime - time;
		var dPosX:Float;
		var dPosY:Float;
		var dPosZ:Float;
		if (absolute) {
			var x:Float = this.x.interpolate(t1);
			var y:Float = this.y.interpolate(t1);
			var z:Float = this.z.interpolate(t1);

			dPosX = x - pos.x;
			dPosY = y - pos.y;
			dPosZ = z - pos.z;
		} else {
			var x:Float = this.x.accumulate(t0, t1);
			var y:Float = this.y.accumulate(t0, t1);
			var z:Float = this.z.accumulate(t0, t1);
			var r:Float = this.r.accumulate(t0, t1);
			var s:Float = this.s.accumulate(t0, t1);

			dPosX = x + r * Math.cos(pos.dir.valueRadian) + s * Math.sin(pos.dir.valueRadian);
			dPosY = y + r * Math.sin(pos.dir.valueRadian) - s * Math.cos(pos.dir.valueRadian);
			dPosZ = z;
		}
		mortal.hitFrames.clear();
		for (hitFrame in this.hitFrames) mortal.hitFrames.add(hitFrame);
		mortal.moveDWithHit(field, dPosX, dPosY, dPosZ, dHitType);
	}
}
