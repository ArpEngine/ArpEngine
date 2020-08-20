package arpx.text;

import arp.domain.IArpObject;
import arpx.text.FixedTextData;

@:arpType("text", "null")
class TextData implements IArpObject {

	public function new() return;

	public function publish(params:ArpFormatParams = null):String return "";
	public function publishAnon(params:Dynamic = null):String return "";

	public function publishTextData(params:ArpFormatParams = null):TextData {
		return FixedTextData.allocObject(this.arpDomain, this.publish(params));
	}

	public function publishTextDataAnon(anon:Dynamic = null):TextData {
		return FixedTextData.allocObject(this.arpDomain, this.publish(ArpFormatParams.fromAnon(anon)));
	}
}
