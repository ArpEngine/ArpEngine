package arpx.input;

import arp.ds.IMap;
import arp.ds.impl.StdMap;
import arp.task.ITickable;
import arp.domain.IArpObject;
import arpx.impl.cross.input.IInputImpl;
import arpx.input.focus.IFocusNode;

@:arpType("input", "null")
class Input implements IArpObject implements IFocusNode<Input> implements ITickable implements IInputImpl {

	@:arpImpl private var arpImpl:IInputImpl;

	public var inputAxes:IMap<String, InputAxis>;

	public function new() {
		this.inputAxes = new StdMap<String, InputAxis>();
	}

	public function axis(button:String):InputAxis {
		if (this.inputAxes.hasKey(button)) {
			return this.inputAxes.get(button);
		}
		var axis:InputAxis = new InputAxis();
		this.inputAxes.set(button, axis);
		return axis;
	}

	public function clear():Void this.inputAxes.clear();

	public function tick(timeslice:Float):Bool return true;

	public function findFocus(other:Null<Input>):Null<Input> return other;
	public function updateFocus(target:Null<Input>):Void return;

}


