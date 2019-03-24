package arpx.structs.params;

import arpx.structs.ArpDirection;

class EmptyArpParams implements IArpParamsRead {

	public function new() return;

	inline public function get(key:ArpParamsKey):ArpParamsValue return null;
	inline public function keys():Iterator<ArpParamsKey> return ArpParamsKey.keys();

	public function getInt(key:ArpParamsKey, defaultValue = null):Null<Int> return defaultValue;
	public function getFloat(key:ArpParamsKey, defaultValue = null):Null<Float> return defaultValue;
	public function getString(key:ArpParamsKey, defaultValue = null):String return defaultValue;
	public function getBool(key:ArpParamsKey, defaultValue = null):Null<Bool> return defaultValue;
	public function getArpDirection(key:ArpParamsKey, defaultValue = null):ArpDirection return defaultValue;

	public function getAsString(key:ArpParamsKey, defaultValue = null):String return defaultValue;

	public function toString():String return [].join(",");
}
