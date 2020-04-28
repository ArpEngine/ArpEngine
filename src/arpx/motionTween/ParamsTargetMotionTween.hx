package arpx.motionTween;

import arpx.structs.ArpCurve;
import arpx.structs.ArpParams;
import arpx.structs.ArpPosition;

@:arpType("motionTween", "paramsTarget")
class ParamsTargetMotionTween extends MotionTween {

	@:arpField public var key:String;
	@:arpField public var target:Float;
	@:arpField public var curve:ArpCurve;

	public function new() super();

	override public function update(position:ArpPosition, target:ArpPosition, params:ArpParams, oldTime:Float, newTime:Float):Void {
		var t0:Float = oldTime - time.minValue;
		var t1:Float = newTime - time.minValue;
		var factor:Float = this.curve.accumulateByRatio(t0, t1);
		params.set(this.key, params.getFloatOrDefault(this.key) * (1 - factor) + this.target * factor);
	}
}
