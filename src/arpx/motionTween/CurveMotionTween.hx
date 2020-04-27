package arpx.motionTween;

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

	override public function updatePosition(position:ArpPosition, target:ArpPosition, oldTime:Float, newTime:Float):Void {
		var t0:Float = oldTime - time.minValue;
		var t1:Float = newTime - time.minValue;
		if (absolute) {
			var x:Float = this.x.interpolate(t1);
			var y:Float = this.y.interpolate(t1);
			var z:Float = this.z.interpolate(t1);

			position.x = x;
			position.y = y;
			position.z = z;

		} else {
			var x:Float = this.x.accumulate(t0, t1);
			var y:Float = this.y.accumulate(t0, t1);
			var z:Float = this.z.accumulate(t0, t1);
			var r:Float = this.r.accumulate(t0, t1);
			var s:Float = this.s.accumulate(t0, t1);

			position.x += x + r * Math.cos(position.dir.valueRadian) + s * Math.sin(position.dir.valueRadian);
			position.y += y + r * Math.sin(position.dir.valueRadian) - s * Math.cos(position.dir.valueRadian);
			position.z += z;
		}
	}
}
