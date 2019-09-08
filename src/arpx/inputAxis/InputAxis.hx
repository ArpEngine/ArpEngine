package arpx.inputAxis;

import arp.domain.IArpObject;
import arp.ds.impl.ArrayList;
import arp.task.ITickableChild;
import arpx.input.Input;
import arpx.input.InputSource;

@:arpType("inputAxis")
class InputAxis implements ITickableChild<Input> implements IArpObject {

	public var value(default, null):Float = 0;

	private var bindings:ArrayList<InputAxisBinding>;
	private var nextValue:Float = 0;

	private var state(default, null):Int = 0;
	private var stateDuration(default, null):Float = 0;
	private var threshold(default, default):Float = 0.6;

	public var isUp(get, null):Bool;
	inline private function get_isUp():Bool return this.state == 0;

	public var isDown(get, null):Bool;
	inline private function get_isDown():Bool return this.state != 0;

	public var isTrigger(get, null):Bool;
	inline private function get_isTrigger():Bool return this.stateDuration == 0;

	public var isTriggerUp(get, null):Bool;
	inline private function get_isTriggerUp():Bool return this.isTrigger && this.isUp;

	public var isTriggerDown(get, null):Bool;
	inline private function get_isTriggerDown():Bool return this.isTrigger && this.isDown;

	public function new() {
		bindings = new ArrayList<InputAxisBinding>();
	}

	public function bind(source:InputSource, factor:Float = 1.0):Void this.bindings.push(new InputAxisBinding(source, factor));

	public function unbind():Void this.bindings.clear();

	public function tickChild(timeslice:Float, parent:Input):Bool {
		for (binding in this.bindings) {
			var value:Float = parent.getState(binding.source);
			this.nextValue += value * binding.factor;
		}

		var newState:Int = if (this.nextValue >= threshold) 1 else if (this.nextValue <= -threshold) -1 else 0;
		if (this.state != newState) {
			this.stateDuration = 0;
			this.state = newState;
		} else {
			this.stateDuration += timeslice;
		}

		this.value = this.nextValue;
		this.nextValue = 0;
		return true;
	}
}

private class InputAxisBinding {

	public var source:InputSource;
	public var factor:Float;

	public function new(source:InputSource, factor:Float) {
		this.source = source;
		this.factor = factor;
	}
}
