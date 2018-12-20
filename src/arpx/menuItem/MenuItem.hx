package arpx.menuItem;

import arp.domain.IArpObject;
import arpx.proc.Proc;
import arpx.text.TextData;

@:arpType("menuItem")
class MenuItem implements IArpObject {
	@:arpField public var text:TextData;
	@:arpField public var proc:Proc;

	public function new() {
	}
}


