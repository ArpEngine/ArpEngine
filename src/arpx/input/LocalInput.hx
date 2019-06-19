package arpx.input;

import arp.ds.impl.ArrayList;
import arpx.impl.cross.input.LocalInputImpl;

@:arpType("input", "local")
class LocalInput extends Input {

	private var bindings:ArrayList<LocalInputBinding>;
	private var states:Map<InputSource, Float>;
	// FIXME mouse may be inside viewport or outside (thus coordinates unavailable)

	@:arpImpl private var arpImpl:LocalInputImpl;

	public function new() {
		super();
		this.bindings = new ArrayList<LocalInputBinding>();
		this.states = new Map<InputSource, Float>();
	}

	public function setState(source:InputSource, value:Float = 1.0):Void {
		this.states.set(source, value);
	}

	public function unsetState(source:InputSource, value:Float = 0.0):Void {
		this.states.set(source, value);
	}

	public function bind(source:InputSource, axis:String, factor:Float):Void {
		this.bindings.push(new LocalInputBinding(source, axis, factor));
		this.states.set(source, 0.0);
	}

	public function bindKeyButton(keyCode:Int, axis:String):Void {
		this.bind(InputSource.Key(keyCode), axis, 1.0);
	}

	public function bindKeyAxis(keyCode:Int, axis:String, factor:Float):Void {
		this.bind(InputSource.Key(keyCode), axis, factor);
	}

	public function bindMouse(axisX:String = null, axisY:String = null, axisLeft:String = null, factorLeft:Float = 1.0):Void {
		if (axisX != null) this.bind(InputSource.MouseX, axisX, 1.0);
		if (axisY != null) this.bind(InputSource.MouseY, axisY, 1.0);
		if (axisLeft != null) this.bind(InputSource.MouseLeft, axisLeft, factorLeft);
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

	public var source:InputSource;
	public var axis:String;
	public var factor:Float;

	public function new(source:InputSource, axis:String, factor:Float) {
		this.source = source;
		this.axis = axis;
		this.factor = factor;
	}
}
