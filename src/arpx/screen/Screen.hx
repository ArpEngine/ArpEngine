package arpx.screen;

import arpx.input.focus.IInteractable;
import arp.domain.IArpObject;
import arp.task.ITickable;
import arpx.impl.cross.screen.IScreenImpl;
import arpx.input.focus.IFocusNode;
import arpx.input.Input;

@:arpType("screen", "null")
class Screen implements IArpObject implements ITickable implements IInteractable implements IFocusNode<Screen> implements IScreenImpl {
	@:arpField public var ticks:Bool = true;
	@:arpField public var visible:Bool = true;
	@:arpField public var focused:Bool = false;

	@:arpImpl private var arpImpl:IScreenImpl;

	public function new() return;

	public function tick(timeslice:Float):Bool {
		return true;
	}

	public function interact(input:Input):Bool {
		return false;
	}

	public function findFocus(other:Null<Screen>):Null<Screen> {
		return null;
	}
}
