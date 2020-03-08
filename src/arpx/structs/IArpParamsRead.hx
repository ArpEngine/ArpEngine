package arpx.structs;

import arpx.structs.params.ArpParamsValue;

interface IArpParamsRead {
	function getInt(key:ArpParamsKey, defaultValue:Int = null):Null<Int>;
	function getFloat(key:ArpParamsKey, defaultValue:Float = null):Null<Float>;
	function getString(key:ArpParamsKey, defaultValue:String = null):Null<String>;
	function getBool(key:ArpParamsKey, defaultValue:Bool = null):Null<Bool>;
	function getArpDirection(key:ArpParamsKey, defaultValue:ArpDirection = null):Null<ArpDirection>;

	function getIntOrDefault(key:ArpParamsKey, defaultValue:Int = 0):Int;
	function getFloatOrDefault(key:ArpParamsKey, defaultValue:Float = 0.0):Float;
	function getStringOrDefault(key:ArpParamsKey, defaultValue:String = ""):String;
	function getBoolOrDefault(key:ArpParamsKey, defaultValue:Bool = false):Bool;
	function getArpDirectionOrDefault(key:ArpParamsKey, defaultValue:ArpDirection):ArpDirection;

	function getAsString(key:ArpParamsKey, defaultValue:String = null):String;

	function get(key:ArpParamsKey):ArpParamsValue;
	function keys():Iterator<ArpParamsKey>;

	function toString():String;
}

