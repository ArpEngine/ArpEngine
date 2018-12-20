package arpx.text;

import arp.domain.IArpObject;
import arpx.structs.ArpParams;

@:arpType("text", "null")
class TextData implements IArpObject {
	public function new() {
	}

	public function publish(params:ArpParams = null):String {
		return "";
	}
}
