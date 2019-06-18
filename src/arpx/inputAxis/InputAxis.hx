package arpx.inputAxis;

import arp.domain.IArpObject;
import arp.task.ITickableChild;
import arpx.input.Input;

@:arpType("inputAxis")
class InputAxis implements ITickableChild<Input> implements IArpObject {

	public var value(default, null):Float = 0;

	private var nextValue(default, default):Float = 0;

	private var state(default, null):Bool = false;
	private var level(default, null):Float = 0;
	private var stateDuration(default, null):Float = 0;
	private var levelDuration(default, null):Float = 0;
	private var threshold(default, default):Float = 0.6;

	public var isUp(get, null):Bool;
	inline private function get_isUp():Bool return !this.state;

	public var isDown(get, null):Bool;
	inline private function get_isDown():Bool return this.state;

	public var isTrigger(get, null):Bool;
	inline private function get_isTrigger():Bool return this.levelDuration == 0;

	public var isTriggerUp(get, null):Bool;
	inline private function get_isTriggerUp():Bool return !this.state && this.stateDuration == 0;

	public var isTriggerDown(get, null):Bool;
	inline private function get_isTriggerDown():Bool return this.state && this.stateDuration == 0;

	public function new() return;

	public function tickChild(timeslice:Float, parent:Input):Bool {
		var newState:Bool = this.nextValue >= threshold || this.nextValue <= -threshold;
		if (this.state != newState) {
			this.stateDuration = 0;
			this.state = newState;
		} else {
			this.stateDuration += timeslice;
		}

		var newLevel:Int = Math.floor(this.nextValue / this.threshold);
		var newLevel:Int = Math.floor(this.nextValue / this.threshold);
		if (newLevel < 0) newLevel++;
		if (this.level != newLevel) {
			this.levelDuration = 0;
			this.level = newLevel;
		} else {
			this.levelDuration += timeslice;
		}

		this.value = this.nextValue;
		this.nextValue = 0;
		return true;
	}
}
