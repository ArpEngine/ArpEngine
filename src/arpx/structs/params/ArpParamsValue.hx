package arpx.structs.params;

abstract ArpParamsValue(Any) from Any to Any {

	inline public function new(value:Any) this = value;

	@:from inline public static function fromInt(value:Int):ArpParamsValue return new ArpParamsValue(value);
	@:from inline public static function fromFloat(value:Float):ArpParamsValue return new ArpParamsValue(value);
	@:from inline public static function fromString(value:String):ArpParamsValue return new ArpParamsValue(value);
	@:from inline public static function fromBool(value:Bool):ArpParamsValue return new ArpParamsValue(value);
	@:from inline public static function fromArpDirection(value:ArpDirection):ArpParamsValue return new ArpParamsValue(value);
	@:from inline public static function fromArpColor(value:ArpColor):ArpParamsValue return new ArpParamsValue(value);

	@:to inline public function toInt():Int return this;
	@:to inline public function toFloat():Float return this;
	@:to inline public function toString():String return this;
	@:to inline public function toBool():Bool return this;
	@:to inline public function toArpDirection():ArpDirection return this;
	@:to inline public function toArpColor():ArpColor return this;

	public var value(get, set):Int;
	inline private function get_value():UInt return toArpDirection().value;
	inline private function set_value(value:UInt):UInt return toArpDirection().value = value;
}
