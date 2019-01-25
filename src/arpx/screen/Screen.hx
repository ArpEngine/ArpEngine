package arpx.screen;

import arp.domain.IArpObject;
import arp.task.ITickable;
import arpx.impl.cross.screen.IScreenImpl;
import arpx.input.focus.IFocusNode;
import arpx.input.Input;

@:arpType("screen", "null")
class Screen implements IArpObject implements ITickable implements IFocusNode<Input> implements IScreenImpl {
	@:arpField public var ticks:Bool = true;
	@:arpField public var visible:Bool = true;

	@:arpImpl private var arpImpl:IScreenImpl;

	public function new() return;

	public function tick(timeslice:Float):Bool {
		return true;
	}

	public function findFocus(other:Null<Input>):Null<Input> {
		return null;
	}

	public function updateFocus(target:Null<Input>):Void {
	}
}
