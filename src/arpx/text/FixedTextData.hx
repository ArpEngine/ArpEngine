package arpx.text;

import arp.domain.ArpDomain;
import arpx.structs.ArpParams;

@:arpType("text")
class FixedTextData extends TextData {

	@:arpField public var value:String = null;

	public function new() {
		super();
	}

	override public function publish(params:ArpParams = null):String {
		return this.value;
	}

	public static function allocObject(arpDomain:ArpDomain, value:String):FixedTextData {
		var result:FixedTextData = arpDomain.allocObject(FixedTextData);
		result.value = value;
		return result;
	}
}


