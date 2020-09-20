package arpx.text;

import arp.domain.ArpDomain;

@:arpType("text")
class FixedTextData extends TextData {

	@:arpField public var value:String = null;

	public function new() {
		super();
	}

	override public function publish(params:ArpFormatParams = null):String {
		return this.value;
	}

	override public function publishAnon(anon:Dynamic = null):String {
		return this.value;
	}

	public static function allocFixedTextData(arpDomain:ArpDomain, value:String):FixedTextData {
		var result:FixedTextData = arpDomain.allocObject(FixedTextData);
		result.value = value;
		return result;
	}

	@:noUsing
	inline public static function allocObject(arpDomain:ArpDomain, value:String):FixedTextData return allocFixedTextData(arpDomain, value);
}


