package arpx.input;

import arpx.impl.cross.input.LocalInputImpl;

@:arpType("input", "local")
class LocalInput extends Input {

	// FIXME mouse may be inside viewport or outside (thus coordinates unavailable)

	@:arpImpl private var arpImpl:LocalInputImpl;

	public function new() super();

	public function bind(source:InputSource, axis:String, factor:Float):Void {
		this.axis(axis).bind(source, factor);
	}

	public function bindKeyButton(keyCode:Int, axis:String):Void {
		this.axis(axis).bind(InputSource.Key(keyCode), 1.0);
	}

	public function bindKeyAxis(keyCode:Int, axis:String, factor:Float):Void {
		this.axis(axis).bind(InputSource.Key(keyCode), factor);
	}

	public function bindMouse(axisX:String = null, axisY:String = null, axisLeft:String = null, factorLeft:Float = 1.0):Void {
		if (axisX != null) this.bind(InputSource.MouseX, axisX, 1.0);
		if (axisY != null) this.bind(InputSource.MouseY, axisY, 1.0);
		if (axisLeft != null) this.bind(InputSource.MouseLeft, axisLeft, factorLeft);
	}
}
