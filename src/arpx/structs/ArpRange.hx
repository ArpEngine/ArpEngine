package arpx.structs;

import arp.domain.IArpStruct;
import arp.persistable.IPersistInput;
import arp.persistable.IPersistOutput;
import arp.seed.ArpSeed;
import arp.utils.ArpStringUtil;

@:arpStruct("Range")
@:arpStructPlaceholder("min..max", { min: "min" , max: "max" })
class ArpRange implements IArpStruct {

	//TODO assure min < max
	public var minValue:Float;
	public var maxValue:Float;

	public var range(get, set):Float;
	private function get_range():Float return this.maxValue - this.minValue;
	private function set_range(value:Float):Float {
		this.maxValue = this.minValue + value;
		return value;
	}

	public var hasValue(get, never):Bool;
	private function get_hasValue():Bool return this.maxValue >= this.minValue;

	public function new(minValue:Float = 0, maxValue:Float = -1) {
		this.minValue = minValue;
		this.maxValue = maxValue;
	}

	public function initWithSeed(seed:ArpSeed):ArpRange {
		if (seed == null) return this;
		var value:String = seed.value;
		if (value != null) return this.initWithString(value, seed.env.getUnit);

		for (child in seed) {
			switch (child.seedName) {
				case "min": this.minValue = ArpStringUtil.parseFloatDefault(child.value);
				case "max": this.maxValue = ArpStringUtil.parseFloatDefault(child.value);
			}
		}
		return this;
	}

	public function initWithString(definition:String):ArpRange {
		if (definition == null) return this;
		var ereg:EReg = ~/^\s*([^\s]*)\s*\.\.\s*([^\s]*)\s*$/;
		if (ereg.match(definition)) {
			this.minValue = ArpStringUtil.parseFloatDefault(ereg.matched(1));
			this.maxValue = ArpStringUtil.parseFloatDefault(ereg.matched(2));
		}
		return this;
	}

	public function clone():ArpRange {
		return new ArpRange(this.minValue, this.maxValue);
	}

	public function copyFrom(source:ArpRange = null):ArpRange {
		this.minValue = source.minValue;
		this.maxValue = source.maxValue;
		return this;
	}

	public function toString():String {
		return "[ArpRange " + this.minValue + ".." + this.maxValue + " ]";
	}


	public function contains(value:Float):Bool {
		return value >= this.minValue && value <= this.maxValue;
	}

	public function normalize(value:Float):Float {
		var mod:Float = (value - this.minValue) % (this.maxValue - this.minValue);
		return (((mod != 0) == (value > this.minValue))) ? (this.minValue + mod) : (this.maxValue + mod);
	}

	public function limit(value:Float):Float {
		return ((value < this.minValue)) ? this.minValue : ((value > this.maxValue)) ? this.maxValue : value;
	}

	public function toArray(step:Float = 1, byRatio:Bool = false):Array<Float> {
		var result:Array<Float> = [];
		var i:Float;
		if (byRatio) {
			step = this.range * step;
		}
		if (step < 0) {
			i = this.maxValue;
			while (i >= this.minValue) {
				result.push(i);
				i += step;
			}
		}
		else {
			if (step == 0) {
				step = 1;
			}
			i = this.minValue;
			while (i <= this.maxValue) {
				result.push(i);
				i += step;
			}
		}
		return result;
	}

	public function split(step:Float = 1, relative:Bool = false):Array<String> {
		var result:Array<String> = [];
		var i:Float;
		if (relative) {
			step = this.range * step;
		}
		if (step < 0) {
			i = this.maxValue;
			while (i >= this.minValue) {
				result.push(Std.string(i));
				i += step;
			}
		}
		else {
			if (step == 0) {
				step = 1;
			}
			i = this.minValue;
			while (i <= this.maxValue) {
				result.push(Std.string(i));
				i += step;
			}
		}
		return result;
	}

	public function random():Float {
		return this.minValue + Math.random() * (this.maxValue - this.minValue);
	}

	public function randomInt():Int {
		return Std.int(this.minValue + Math.random() * (Math.ceil(this.maxValue) - Math.floor(this.minValue) + 1));
	}

	public function readSelf(input:IPersistInput):Void {
		this.minValue = input.readDouble("min");
		this.maxValue = input.readDouble("max");
	}

	public function writeSelf(output:IPersistOutput):Void {
		output.writeDouble("min", this.minValue);
		output.writeDouble("max", this.maxValue);
	}
}


