package arpx.input;

import arp.ds.impl.ArrayList;
import arpx.impl.cross.input.LocalInputImpl;

@:arpType("input", "local")
class LocalInput extends PhysicalInput {

	// TODO enum LocalInputSource
	private var keyBindings:ArrayList<LocalKeyInputBinding>;
	private var keyStates:Map<Int, Bool>;
	// FIXME mouse may be inside viewport or outside (thus coordinates unavailable)
	private var mouseXBinding:LocalMouseInputBinding;
	private var mouseYBinding:LocalMouseInputBinding;
	private var mouseLeftBinding:LocalMouseInputBinding;
	private var mouseX:Float;
	private var mouseY:Float;
	private var mouseLeft:Bool;

	@:arpImpl private var arpImpl:LocalInputImpl;

	public function new() {
		super();
		this.keyBindings = new ArrayList<LocalKeyInputBinding>();
		this.keyStates = new Map<Int, Bool>();
	}

	public function bindKeyButton(keyCode:Int, axis:String):Void {
		keyBindings.push(new LocalKeyInputBinding(keyCode, axis, 1.0));
	}

	public function bindKeyAxis(keyCode:Int, axis:String, factor:Float):Void {
		keyBindings.push(new LocalKeyInputBinding(keyCode, axis, factor));
	}

	public function bindMouse(axisX:String = null, axisY:String = null, axisLeft:String = null, factorLeft:Float = 1.0):Void {
		this.mouseXBinding = if (axisX != null) new LocalMouseInputBinding(axisX, 1.0) else null;
		this.mouseYBinding = if (axisY != null) new LocalMouseInputBinding(axisY, 1.0) else null;
		this.mouseLeftBinding = if (axisLeft != null) new LocalMouseInputBinding(axisLeft, factorLeft) else null;
	}

	public function unbind():Void {
		keyBindings.clear();
	}

	override public function tick(timeslice:Float):Bool {
		for (binding in this.keyBindings) {
			if (!this.keyStates.get(binding.keyCode)) continue;
			@:privateAccess this.axis(binding.axis).nextValue += binding.factor;
		}
		if (this.mouseXBinding != null) {
			@:privateAccess this.axis(this.mouseXBinding.axis).nextValue = this.mouseX;
		}
		if (this.mouseYBinding != null) {
			@:privateAccess this.axis(this.mouseYBinding.axis).nextValue = this.mouseY;
		}
		if (this.mouseLeftBinding != null) {
			@:privateAccess this.axis(this.mouseLeftBinding.axis).nextValue != this.mouseLeftBinding.factor;
		}
		for (axis in this.inputAxes) axis.tick(timeslice);
		return true;
	}
}

private class LocalKeyInputBinding {

	public var keyCode:Int;
	public var axis:String;
	public var factor:Float;

	public function new(keyCode:Int, axis:String, factor:Float) {
		this.keyCode = keyCode;
		this.axis = axis;
		this.factor = factor;
	}
}

private class LocalMouseInputBinding {

	public var axis:String;
	public var factor:Float;

	public function new(axis:String, factor:Float) {
		this.axis = axis;
		this.factor = factor;
	}
}

