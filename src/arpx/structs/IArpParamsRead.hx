package arpx.structs;

interface IArpParamsRead {
	function getInt(key:ArpParamsKey, defaultValue:Int = null):Null<Int>;
	function getFloat(key:ArpParamsKey, defaultValue:Float = null):Null<Float>;
	function getString(key:ArpParamsKey, defaultValue:String = null):String;
	function getBool(key:ArpParamsKey, defaultValue:Bool = null):Null<Bool>;
	function getArpDirection(key:ArpParamsKey, defaultValue:ArpDirection = null):ArpDirection;

	function getAsString(key:ArpParamsKey, defaultValue:String = null):String;

	function get(key:ArpParamsKey):Dynamic;
	function keys():Iterator<ArpParamsKey>;

	function toString():String;
}

