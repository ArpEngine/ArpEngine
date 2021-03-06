package arpx.structs.params;

@:forward
abstract ArpParamsProxy(ArpParams) from ArpParams to ArpParams {

	inline public function new(value:ArpParams) this = value;

	@:arrayAccess inline private function arrayGet(k:String):ArpParamsValue return this.get(k);
	@:arrayAccess inline private function arraySet(k:String, v:ArpParamsValue):ArpParamsValue { this.set(k, v); return v; }
}
