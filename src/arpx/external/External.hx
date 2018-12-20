package arpx.external;

import arp.domain.IArpObject;

@:arpType("external", "external")
class External implements IArpObject {

	public function new() {
	}

	public function load(force:Bool = false):Void {
		//override
	}

	public function unload():Void {
		//override
	}

}
