package arpx.input;

import arp.domain.IArpObject;
import arp.ds.IMap;
import arp.task.ITickable;
import arpx.impl.cross.input.IInputImpl;
import arpx.inputAxis.InputAxis;

@:arpType("input", "null")
class Input implements IArpObject implements ITickable implements IInputImpl {

	@:arpImpl private var arpImpl:IInputImpl;

	@:arpBarrier @:arpField(true) public var inputAxes:IMap<String, InputAxis>;

	private var states:Map<InputSource, Float>;

	public function new() {
		this.states = new Map<InputSource, Float>();
	}

	public function getState(source:InputSource):Float return this.states.get(source);
	public function setState(source:InputSource, value:Float = 1.0):Void this.states.set(source, value);
	public function unsetState(source:InputSource, value:Float = 0.0):Void this.states.set(source, value);

	public function axis(button:String):InputAxis {
		if (this.inputAxes.hasKey(button)) {
			return this.inputAxes.get(button);
		}
		// Expects default input axis
		var axis:InputAxis = this.arpDomain.allocObject(InputAxis);
		this.inputAxes.set(button, axis);
		return axis;
	}

	public function unbind():Void for (axis in this.inputAxes) axis.unbind();

	public function clear():Void this.inputAxes.clear();

	public function tick(timeslice:Float):Bool {
		for (axis in this.inputAxes) axis.tickChild(timeslice, this);
		return true;
	}
}


