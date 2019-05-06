package arpx.impl.js.input;

#if (arp_input_backend_js || arp_backend_display)

import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.input.IInputImpl;
import arpx.impl.cross.input.InputContext;
import arpx.input.LocalInput;
import js.html.Element;
import js.html.Event;
import js.html.KeyboardEvent;
import js.html.MouseEvent;

class LocalInputImpl extends ArpObjectImplBase implements IInputImpl {

	inline private static var KEYDOWN:String = "keydown";
	inline private static var KEYUP:String = "keyup";
	inline private static var DEACTIVATE:String = "focusout"; // "blur";
	inline private static var MOUSEMOVE:String = "mousemove";
	inline private static var MOUSEDOWN:String = "mousedown";
	inline private static var MOUSEUP:String = "mouseup";

	private var input:LocalInput;
	private var target:Element;

	public function new(input:LocalInput) {
		super();
		this.input = input;
	}

	public function listen():Void {
		this.target = InputContext.instance.impl.target;
		this.target.addEventListener(DEACTIVATE, this.onDeactivate);
		this.target.addEventListener(KEYDOWN, this.onKeyDown);
		this.target.addEventListener(KEYUP, this.onKeyUp);
		this.target.addEventListener(MOUSEMOVE, this.onMouseMove);
		this.target.addEventListener(MOUSEDOWN, this.onMouseDown);
		this.target.ownerDocument.addEventListener(MOUSEUP, this.onMouseUp);
	}

	public function purge():Void {
		this.target.removeEventListener(DEACTIVATE, this.onDeactivate);
		this.target.removeEventListener(KEYDOWN, this.onKeyDown);
		this.target.removeEventListener(KEYUP, this.onKeyUp);
		this.target.removeEventListener(MOUSEMOVE, this.onMouseMove);
		this.target.removeEventListener(MOUSEDOWN, this.onMouseDown);
		this.target.ownerDocument.removeEventListener(MOUSEUP, this.onMouseUp);
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

	private function onMouseMove(event:MouseEvent):Void {
		@:privateAccess this.input.mouseX = event.x;
		@:privateAccess this.input.mouseY = event.y;
	}

	private function onMouseDown(event:MouseEvent):Void {
		@:privateAccess this.input.mouseLeft = true;
	}

	private function onMouseUp(event:MouseEvent):Void {
		@:privateAccess this.input.mouseLeft = false;
	}
}

#end
