package arpx.text;

import arp.domain.IArpObject;
import arpx.structs.ArpParams;
import arpx.text.FixedTextData;

@:arpType("text", "null")
class TextData implements IArpObject {

	public function new() return;

	public function publish(params:ArpParams = null):String return "";

	public function publishTextData(params:ArpParams = null):TextData {
		return FixedTextData.allocObject(this.arpDomain, this.publish(params));
	}
}
