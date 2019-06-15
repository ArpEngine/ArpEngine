package arpx.input;

import arp.ds.IMap;
import arp.task.ITickable;
import arp.domain.IArpObject;
import arpx.impl.cross.input.IInputImpl;
import arpx.inputAxis.InputAxis;

@:arpType("input", "null")
class Input implements IArpObject implements ITickable implements IInputImpl {

	@:arpImpl private var arpImpl:IInputImpl;

	@:arpBarrier @:arpField public var inputAxes:IMap<String, InputAxis>;

	public function new() return;

	public function axis(button:String):InputAxis {
		if (this.inputAxes.hasKey(button)) {
			return this.inputAxes.get(button);
		}
		var axis:InputAxis = this.arpDomain.allocObject(InputAxis);
		this.inputAxes.set(button, axis);
		return axis;
	}

	public function clear():Void this.inputAxes.clear();

	public function tick(timeslice:Float):Bool return true;
}


