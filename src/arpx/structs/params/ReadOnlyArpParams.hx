package arpx.structs.params;

import arpx.structs.ArpDirection;
import arpx.structs.macro.ArpParamsMacros;

class ReadOnlyArpParams implements IArpParamsRead {

	private var impl:Array<ArpParamsValue>;

	public function new() this.impl = [];

	inline public function get(key:ArpParamsKey):ArpParamsValue return this.impl[key.index];
	inline public function keys():Iterator<ArpParamsKey> return ArpParamsKey.keys();

	public function getInt(key:ArpParamsKey, defaultValue = null):Null<Int> return ArpParamsMacros.getSafe(key, defaultValue, Int);
	public function getFloat(key:ArpParamsKey, defaultValue = null):Null<Float> return ArpParamsMacros.getSafe(key, defaultValue, Float);
	public function getString(key:ArpParamsKey, defaultValue = null):Null<String> return ArpParamsMacros.getSafe(key, defaultValue, String);
	public function getBool(key:ArpParamsKey, defaultValue = null):Null<Bool> return ArpParamsMacros.getSafe(key, defaultValue, Bool);
	public function getArpDirection(key:ArpParamsKey, defaultValue = null):Null<ArpDirection> return ArpParamsMacros.getSafe(key, defaultValue, ArpDirection);
	public function getArpColor(key:ArpParamsKey, defaultValue = null):Null<ArpColor> return ArpParamsMacros.getSafe(key, defaultValue, ArpColor);

	public function getIntOrDefault(key:ArpParamsKey, defaultValue = 0):Int return ArpParamsMacros.getSafe(key, defaultValue, Int);
	public function getFloatOrDefault(key:ArpParamsKey, defaultValue = 0.0):Float return ArpParamsMacros.getSafe(key, defaultValue, Float);
	public function getStringOrDefault(key:ArpParamsKey, defaultValue = ""):String return ArpParamsMacros.getSafe(key, defaultValue, String);
	public function getBoolOrDefault(key:ArpParamsKey, defaultValue = false):Bool return ArpParamsMacros.getSafe(key, defaultValue, Bool);
	public function getArpDirectionOrDefault(key:ArpParamsKey, defaultValue):ArpDirection return ArpParamsMacros.getSafe(key, defaultValue, ArpDirection);
	public function getArpColorOrDefault(key:ArpParamsKey, defaultValue):ArpColor return ArpParamsMacros.getSafe(key, defaultValue, ArpColor);

	public function getAsString(key:ArpParamsKey, defaultValue = null):String return ArpParamsMacros.getAsString(key, defaultValue);

	public function toString():String {
		var result:Array<String> = [];
		for (name in this.keys()) {
			var value:ArpParamsValue = this.get(name);
			if (value == null) continue;
			if (Std.is(value, ArpDirection)) {
				value = StringTools.hex(cast(value, ArpDirection).value, 8) + ":idir";
			} else if (Std.is(value, ArpColor)) {
				var value32:Int = cast(value, ArpColor).value32;
				var value24:Int = value32 & 0xffffff;
				var alpha:Int = value32 >>> 24;
				value = "#" + StringTools.hex(value24, 6) + "@" + StringTools.hex(alpha, 2) + ":color";
			}
			result.push(name.toString() + ":" + Std.string(value));
		}
		return result.join(",");
	}
}
