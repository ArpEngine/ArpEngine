package arpx.text;

import haxe.Resource;
import arpx.structs.ArpParams;

@:arpType("text", "resource")
class ResourceTextData extends TextData {

	@:arpField public var src:String;

	public function new() {
		super();
	}

	override public function publish(params:ArpParams = null):String {
		return Resource.getString(this.src);
	}
}


