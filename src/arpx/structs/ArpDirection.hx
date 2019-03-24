package arpx.structs;

import arp.domain.IArpStruct;
import arp.persistable.IPersistInput;
import arp.persistable.IPersistOutput;
import arp.seed.ArpSeed;
import arp.utils.ArpStringUtil;

typedef ArpDirectionValue = UInt;

/**
	handled as mutable
*/
@:arpStruct("Direction")
@:arpStructPlaceholder("dir", { value: "dir" })
class ArpDirection implements IArpStruct {

	public static var RIGHT(get, never):ArpDirection;
	public static var RIGHT_DOWN(get, never):ArpDirection;
	public static var DOWN(get, never):ArpDirection;
	public static var LEFT_DOWN(get, never):ArpDirection;
	public static var LEFT(get, never):ArpDirection;
	public static var LEFT_UP(get, never):ArpDirection;
	public static var UP(get, never):ArpDirection;
	public static var RIGHT_UP(get, never):ArpDirection;
	inline private static function get_RIGHT():ArpDirection {return new ArpDirection(0x00000000);}
	inline private static function get_RIGHT_DOWN():ArpDirection {return new ArpDirection(0x20000000);}
	inline private static function get_DOWN():ArpDirection {return new ArpDirection(0x40000000);}
	inline private static function get_LEFT_DOWN():ArpDirection {return new ArpDirection(0x60000000);}
	inline private static function get_LEFT():ArpDirection {return new ArpDirection(0x80000000);}
	inline private static function get_LEFT_UP():ArpDirection {return new ArpDirection(0xA0000000);}
	inline private static function get_UP():ArpDirection {return new ArpDirection(0xC0000000);}
	inline private static function get_RIGHT_UP():ArpDirection {return new ArpDirection(0xE0000000);}

	public static var EAST(get, never):ArpDirection;
	public static var SOUTH_EAST(get, never):ArpDirection;
	public static var SOUTH(get, never):ArpDirection;
	public static var SOUTH_WEST(get, never):ArpDirection;
	public static var WEST(get, never):ArpDirection;
	public static var NORTH_WEST(get, never):ArpDirection;
	public static var NORTH(get, never):ArpDirection;
	public static var NORTH_EAST(get, never):ArpDirection;
	inline private static function get_EAST():ArpDirection {return new ArpDirection(0x00000000);}
	inline private static function get_SOUTH_EAST():ArpDirection {return new ArpDirection(0x20000000);}
	inline private static function get_SOUTH():ArpDirection {return new ArpDirection(0x40000000);}
	inline private static function get_SOUTH_WEST():ArpDirection {return new ArpDirection(0x60000000);}
	inline private static function get_WEST():ArpDirection {return new ArpDirection(0x80000000);}
	inline private static function get_NORTH_WEST():ArpDirection {return new ArpDirection(0xA0000000);}
	inline private static function get_NORTH():ArpDirection {return new ArpDirection(0xC0000000);}
	inline private static function get_NORTH_EAST():ArpDirection {return new ArpDirection(0xE0000000);}

	private static var VALS_BY_NAMES:Map<String, ArpDirectionValue> = [
		"right" => 0x00000000,
		"rightdown" => 0x20000000,
		"down" => 0x40000000,
		"leftdown" => 0x60000000,
		"left" => 0x80000000,
		"leftup" => 0xa0000000,
		"up" => 0xc0000000,
		"rightup" => 0xe0000000,
		"east" => 0x00000000,
		"southeast" => 0x20000000,
		"south" => 0x40000000,
		"southwest" => 0x60000000,
		"west" => 0x80000000,
		"northwest" => 0xa0000000,
		"north" => 0xc0000000,
		"northeast" => 0xe0000000
	];

	inline private static var INT_MAX:Float = 0x7fffffff + 1.0;

	/*inline*/ private static var RAD_TO_VAL:Float = INT_MAX / Math.PI;
	/*inline*/ private static var VAL_TO_RAD:Float = Math.PI / INT_MAX;

	inline private static var DEG_TO_VAL:Float = INT_MAX / 180;
	inline private static var VAL_TO_DEG:Float = 180 / INT_MAX;

	inline private static var REV_TO_VAL:Float = INT_MAX * 2;
	inline private static var VAL_TO_REV:Float = 0.5 / INT_MAX;

	@:isVar
	public var value(default, set):ArpDirectionValue;
	inline private function set_value(value:ArpDirectionValue):ArpDirectionValue return this.value = @:privateAccess haxe.Int32.clamp(value);

	public var valueRadian(get, set):Float;
	private function get_valueRadian():Float {
		return this.value * VAL_TO_RAD;
	}
	private function set_valueRadian(value:Float):Float {
		this.value = Std.int(value * RAD_TO_VAL);
		return value;
	}

	public var valueDegree(get, set):Float;
	private function get_valueDegree():Float {
		return this.value * VAL_TO_DEG;
	}
	private function set_valueDegree(value:Float):Float {
		this.value = Std.int(value * DEG_TO_VAL);
		return value;
	}

	public var valueRevolution(get, set):Float;
	private function get_valueRevolution():Float {
		return this.value * VAL_TO_REV;
	}
	private function set_valueRevolution(value:Float):Float {
		this.value = Std.int(value * REV_TO_VAL);
		return value;
	}

	public function toIndex(dirs:Int):Int {
		return Math.round(this.value * VAL_TO_REV * dirs) % dirs;
	}

	public function new(value:ArpDirectionValue = 0) {
		this.value = value;
	}

	public function clone():ArpDirection {
		return new ArpDirection(this.value);
	}

	public function copyFrom(source:ArpDirection = null):ArpDirection {
		this.value = source.value;
		return this;
	}

	public function valueOf():Int {
		return this.value;
	}

	public function initWithSeed(seed:ArpSeed):ArpDirection {
		if (seed == null) return this;
		return this.initWithString(seed.value);
	}

	public function initWithString(definition:String):ArpDirection {
		if (definition == null) return this;
		if (ArpStringUtil.isNumeric(definition)) {
			this.valueDegree = ArpStringUtil.parseIntDefault(definition);
		} else if (VALS_BY_NAMES.exists(definition)){
			this.value = VALS_BY_NAMES.get(definition);
		}
		return this;
	}

	public static function fromDegree(value:Float):ArpDirection {
		return new ArpDirection(Std.int(value * DEG_TO_VAL));
	}

	public static function fromRadian(value:Float):ArpDirection {
		return new ArpDirection(Std.int(value * RAD_TO_VAL));
	}

	public static function fromRevolution(value:Float):ArpDirection {
		return new ArpDirection(Std.int(value * REV_TO_VAL));
	}

	public function toString():String {
		return "[ArpDirection " + this.valueDegree + " ]";
	}

	public function readSelf(input:IPersistInput):Void {
		this.value = Std.int(input.readUInt32("dir"));
	}

	public function writeSelf(output:IPersistOutput):Void {
		output.writeUInt32("dir", this.value);
	}
}
