package arpx.menuItem;

import arp.domain.IArpObject;
import arpx.proc.Proc;
import arpx.text.TextData;

@:arpType("menuItem")
class MenuItem implements IArpObject {
	@:arpField public var text:TextData;
	@:arpField public var proc:Proc;
	@:arpField public var enabled:Bool = true;

	@:arpField public var hotkey:String;
	@:arpField public var shortcut:String;

	public function new() {
	}
}


