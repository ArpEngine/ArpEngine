package arpx.input;

import arp.task.ITickable;
import arp.domain.IArpObject;
import arpx.impl.cross.input.IInputImpl;
import arpx.input.focus.IFocusNode;

@:arpType("input", "null")
class Input implements IArpObject implements IFocusNode<Input> implements ITickable implements IInputImpl {

	@:arpImpl private var arpImpl:IInputImpl;

	public function new() return;

	public function axis(button:String):InputAxis return new InputAxis();

	public function tick(timeslice:Float):Bool return true;

	public function findFocus(other:Null<Input>):Null<Input> return other;
	public function updateFocus(target:Null<Input>):Void return;

}


