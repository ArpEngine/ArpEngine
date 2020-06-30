package arpx.motionTween;

import arpx.structs.ArpCurve;
import arpx.structs.ArpParams;
import arpx.structs.ArpPosition;

@:arpType("motionTween", "params")
class ParamsMotionTween extends MotionTween {

	@:arpField public var paramsKey:String;
	@:arpField public var curve:ArpCurve;
	@:arpField public var absolute:Bool = false;

	public function new() super();

	override public function update(position:ArpPosition, target:ArpPosition, params:ArpParams, oldTime:Float, newTime:Float):Void {
		var t0:Float = oldTime - time.minValue;
		var t1:Float = newTime - time.minValue;
		if (absolute) {
			params.set(this.paramsKey, this.curve.interpolate(t1));
		} else {
			params.set(this.paramsKey, params.getFloatOrDefault(this.paramsKey) + this.curve.accumulate(t0, t1));
		}
	}
}
