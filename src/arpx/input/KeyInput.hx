package arpx.input;

import arpx.impl.cross.input.KeyInputImpl;

@:arpType("input", "key")
class KeyInput extends Input {

	@:arpImpl private var arpImpl:KeyInputImpl;

	public function new() super();

	public function bindButton(keyCode:Int, axis:String):Void {
		this.axis(axis).bind(InputSource.Key(keyCode), 1.0);
	}

	public function bindAxis(keyCode:Int, axis:String, factor:Float):Void {
		this.axis(axis).bind(InputSource.Key(keyCode), factor);
	}
}
