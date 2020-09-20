package arpx.text;

import haxe.Resource;

@:arpType("text", "resource")
class ResourceTextData extends TextData {

	@:arpField public var src:String;

	public function new() {
		super();
	}

	override public function publish(params:ArpFormatParams = null):String {
		return Resource.getString(this.src);
	}

	override public function publishAnon(anon:Dynamic = null):String {
		return Resource.getString(this.src);
	}
}


