package arpx.input;

import arp.ds.impl.ArrayList;
import arpx.impl.cross.input.LocalInputImpl;
import arpx.input.localInput.LocalInputSource;

@:arpType("input", "local")
class LocalInput extends Input {

	private var bindings:ArrayList<LocalInputBinding>;
	private var states:Map<LocalInputSource, Float>;
	// FIXME mouse may be inside viewport or outside (thus coordinates unavailable)

	@:arpImpl private var arpImpl:LocalInputImpl;

	public function new() {
		super();
		this.bindings = new ArrayList<LocalInputBinding>();
		this.states = new Map<LocalInputSource, Float>();
	}

	public function setState(source:LocalInputSource, value:Float = 1.0):Void {
		this.states.set(source, value);
	}

	public function unsetState(source:LocalInputSource, value:Float = 0.0):Void {
		this.states.set(source, value);
	}

	public function bind(source:LocalInputSource, axis:String, factor:Float):Void {
		this.bindings.push(new LocalInputBinding(source, axis, factor));
		this.states.set(source, 0.0);
	}

	public function bindKeyButton(keyCode:Int, axis:String):Void {
		this.bind(LocalInputSource.Key(keyCode), axis, 1.0);
	}

	public function bindKeyAxis(keyCode:Int, axis:String, factor:Float):Void {
		this.bind(LocalInputSource.Key(keyCode), axis, factor);
	}

	public function bindMouse(axisX:String = null, axisY:String = null, axisLeft:String = null, factorLeft:Float = 1.0):Void {
		if (axisX != null) this.bind(LocalInputSource.MouseX, axisX, 1.0);
		if (axisY != null) this.bind(LocalInputSource.MouseY, axisY, 1.0);
		if (axisLeft != null) this.bind(LocalInputSource.MouseLeft, axisLeft, factorLeft);
	}

	public function unbind():Void {
		this.bindings.clear();
	}

	override public function tick(timeslice:Float):Bool {
		for (binding in this.bindings) {
			var value:Float = this.states.get(binding.source);
			@:privateAccess this.axis(binding.axis).nextValue += value * binding.factor;
		}
		for (axis in this.inputAxes) axis.tickChild(timeslice, this);
		return true;
	}
}

private class LocalInputBinding {

	public var source:LocalInputSource;
	public var axis:String;
	public var factor:Float;

	public function new(source:LocalInputSource, axis:String, factor:Float) {
		this.source = source;
		this.axis = axis;
		this.factor = factor;
	}
}
