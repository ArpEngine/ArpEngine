package arpx.structs.params;

@:forward
abstract ArpParamsProxy(ArpParams) from ArpParams to ArpParams {

	inline public function new(value:ArpParams) this = value;

	@:arrayAccess inline private function arrayGet(k:String):ArpParamsValue return this.get(k);
	@:arrayAccess inline private function arraySet(k:String, v:ArpParamsValue):ArpParamsValue { this.set(k, v); return v; }
}

abstract ArpParamsValue(Dynamic) from Dynamic to Dynamic {

	inline public function new(value:Dynamic) this = value;

	@:from inline private static function fromInt(value:Int):ArpParamsValue return new ArpParamsValue(value);
	@:from inline private static function fromFloat(value:Float):ArpParamsValue return new ArpParamsValue(value);
	@:from inline private static function fromString(value:String):ArpParamsValue return new ArpParamsValue(value);
	@:from inline private static function fromBool(value:Bool):ArpParamsValue return new ArpParamsValue(value);
	@:from inline private static function fromArpDirection(value:ArpDirection):ArpParamsValue return new ArpParamsValue(value);

	@:to inline private function toInt():Int return this;
	@:to inline private function toFloat():Float return this;
	@:to inline private function toString():String return this;
	@:to inline private function toBool():Bool return this;
	@:to inline private function toArpDirection():ArpDirection return this;

	public var value(get, set):Int;
	inline private function get_value():UInt return toArpDirection().value;
	inline private function set_value(value:UInt):UInt return toArpDirection().value = value;
}
