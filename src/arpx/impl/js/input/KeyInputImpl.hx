package arpx.impl.js.input;

#if (arp_input_backend_js || arp_backend_display)

import arpx.impl.cross.input.InputContext;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.input.IInputImpl;
import arpx.input.KeyInput;
import js.html.Element;
import js.html.Event;
import js.html.KeyboardEvent;

class KeyInputImpl extends ArpObjectImplBase implements IInputImpl {

	inline private static var KEYDOWN:String = "keydown";
	inline private static var KEYUP:String = "keyup";
	inline private static var DEACTIVATE:String = "focusout"; // "blur";

	private var input:KeyInput;
	private var target:Element;

	public function new(input:KeyInput) {
		super();
		this.input = input;
	}

	public function listen(context:InputContext):Void {
		this.target = context.impl.target;
		this.target.addEventListener(DEACTIVATE, this.onDeactivate);
		this.target.addEventListener(KEYDOWN, this.onKeyDown);
		this.target.addEventListener(KEYUP, this.onKeyUp);
	}

	public function purge():Void {
		this.target.removeEventListener(DEACTIVATE, this.onDeactivate);
		this.target.removeEventListener(KEYDOWN, this.onKeyDown);
		this.target.removeEventListener(KEYUP, this.onKeyUp);
		this.target = null;
	}

	private function onDeactivate(event:Event):Void {
		this.input.clear();
	}

	private function onKeyDown(event:KeyboardEvent):Void {
		@:privateAccess this.input.keyStates.set(event.keyCode, true);
		event.preventDefault();
	}

	private function onKeyUp(event:KeyboardEvent):Void {
		@:privateAccess this.input.keyStates.set(event.keyCode, false);
		event.preventDefault();
	}
}

#end
