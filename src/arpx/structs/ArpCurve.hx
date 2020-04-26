package arpx.structs;

import arp.curve.CurveBuilder;
import arp.curve.ICurve;
import arp.curve.impl.CurveFlat;
import arp.domain.IArpStruct;
import arp.persistable.IPersistInput;
import arp.persistable.IPersistOutput;
import arp.seed.ArpSeed;

/**
	handled as mutable
*/
@:arpStruct("Curve")
@:arpStructPlaceholder("x0,...,x1,l:class", { value: "0,0,0,0,0" })
class ArpCurve implements IArpStruct {

	private var impl:ICurve;
	private static var _empty:CurveFlat = new CurveFlat(0, 0);

	public function new() {
		this.impl = _empty;
	}

	public function initWithSeed(seed:ArpSeed):ArpCurve {
		if (seed == null) return this;
		return initWithString(seed.value, seed.env.getUnit);
	}

	public function initWithString(definition:String, getUnit:String->Float):ArpCurve {
		if (definition == null) return this;
		this.impl = CurveBuilder.build(definition, getUnit);
		return this;
	}

	public function clone():ArpCurve {
		var result:ArpCurve = new ArpCurve();
		result.impl = this.impl;
		return result;
	}

	public function copyFrom(source:ArpCurve = null):ArpCurve {
		this.impl = source.impl;
		return this;
	}

	public function toString():String {
		return "[ArpCurve #" + Std.string(this.impl) + " ]";
	}

	public function readSelf(input:IPersistInput):Void {
		this.impl = CurveBuilder.build(input.readUtf("curve"), Std.parseFloat);
	}

	public function writeSelf(output:IPersistOutput):Void {
		output.writeUtf("curve", impl.toString());
	}

	inline public function interpolate(t:Float):Float return this.impl.interpolate(t);
	inline public function accumulate(t0:Float, t1:Float):Float return this.impl.accumulate(t0, t1);
	public function accumulateByRatio(t0:Float, t1:Float):Float {
		if (t0 == this.impl.l) {
			return 0;
		} else if (t1 == this.impl.l) {
			return 1;
		} else {
			var x0 = this.impl.interpolate(t0);
			var x1 = this.impl.interpolate(t1);
			return if (x0 == 1) 0 else (x1 - x0) / (1 - x0);
		}
	}
}
