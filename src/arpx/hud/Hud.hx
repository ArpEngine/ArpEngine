package arpx.hud;

import arp.domain.IArpObject;
import arpx.driver.Driver;
import arpx.impl.cross.hud.IHudImpl;
import arpx.input.focus.IFocusTarget;
import arpx.input.Input;
import arpx.structs.ArpParams;
import arpx.structs.ArpPosition;


@:arpType("hud", "null")
class Hud implements IArpObject implements IFocusTarget implements IHudImpl {
	@:arpBarrier @:arpField public var driver:Driver;
	@:arpField public var position:ArpPosition;
	@:arpField public var visible:Bool = true;
	@:arpField public var focused:Bool = false;
	@:arpField public var params:ArpParams;

	@:arpImpl private var arpImpl:IHudImpl;

	public function new() return;

	public function interact(input:Input):Bool {
		return false;
	}
}
