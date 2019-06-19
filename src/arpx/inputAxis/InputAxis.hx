package arpx.inputAxis;

import arp.domain.IArpObject;
import arp.task.ITickableChild;
import arpx.input.Input;

@:arpType("inputAxis")
class InputAxis implements ITickableChild<Input> implements IArpObject {

	public var value(default, null):Float = 0;

	private var nextValue(default, default):Float = 0;

	private var state(default, null):Bool = false;
	private var stateDuration(default, null):Float = 0;
	private var threshold(default, default):Float = 0.6;

	public var isUp(get, null):Bool;
	inline private function get_isUp():Bool return !this.state;

	public var isDown(get, null):Bool;
	inline private function get_isDown():Bool return this.state;

	public var isTrigger(get, null):Bool;
	inline private function get_isTrigger():Bool return this.stateDuration == 0;

	public var isTriggerUp(get, null):Bool;
	inline private function get_isTriggerUp():Bool return this.isTrigger && !this.state;

	public var isTriggerDown(get, null):Bool;
	inline private function get_isTriggerDown():Bool return this.isTrigger && this.state;

	public function new() return;

	public function tickChild(timeslice:Float, parent:Input):Bool {
		var newState:Bool = this.nextValue >= threshold || this.nextValue <= -threshold;
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
