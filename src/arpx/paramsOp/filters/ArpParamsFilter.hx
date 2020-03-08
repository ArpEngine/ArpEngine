package arpx.paramsOp.filters;

import arpx.structs.ArpDirection;
import arpx.structs.ArpParamsKey;
import arpx.structs.IArpParamsRead;
import arpx.structs.macro.ArpParamsMacros;
import arpx.structs.params.ArpParamsValue;

class ArpParamsFilter implements IArpParamsRead {
	private var params:IArpParamsRead;
	public function new(params:IArpParamsRead) this.params = params;

	public function getInt(key:ArpParamsKey, defaultValue:Int = null):Null<Int> return ArpParamsMacros.getSafe(key, defaultValue, Int);
	public function getFloat(key:ArpParamsKey, defaultValue:Float = null):Null<Float> return ArpParamsMacros.getSafe(key, defaultValue, Float);
	public function getString(key:ArpParamsKey, defaultValue:String = null):Null<String> return ArpParamsMacros.getSafe(key, defaultValue, String);
	public function getBool(key:ArpParamsKey, defaultValue:Bool = null):Null<Bool> return ArpParamsMacros.getSafe(key, defaultValue, Bool);
	public function getArpDirection(key:ArpParamsKey, defaultValue:ArpDirection = null):Null<ArpDirection> return ArpParamsMacros.getSafe(key, defaultValue, ArpDirection);

	public function getIntOrDefault(key:ArpParamsKey, defaultValue:Int = 0):Int return ArpParamsMacros.getSafe(key, defaultValue, Int);
	public function getFloatOrDefault(key:ArpParamsKey, defaultValue:Float = 0):Float return ArpParamsMacros.getSafe(key, defaultValue, Float);
	public function getStringOrDefault(key:ArpParamsKey, defaultValue:String = ""):String return ArpParamsMacros.getSafe(key, defaultValue, String);
	public function getBoolOrDefault(key:ArpParamsKey, defaultValue:Bool = false):Bool return ArpParamsMacros.getSafe(key, defaultValue, Bool);
	public function getArpDirectionOrDefault(key:ArpParamsKey, defaultValue:ArpDirection):ArpDirection return ArpParamsMacros.getSafe(key, defaultValue, ArpDirection);

	public function getAsString(key:ArpParamsKey, defaultValue:String = null):String return ArpParamsMacros.getAsString(key, defaultValue);

	public function get(key:ArpParamsKey):ArpParamsValue return this.params.get(key);
	public function keys():Iterator<ArpParamsKey> return this.params.keys();

	public function toString():String return this.params.toString();
}

