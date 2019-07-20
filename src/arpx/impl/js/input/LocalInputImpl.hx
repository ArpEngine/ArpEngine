package arpx.impl.js.input;

#if (arp_input_backend_js || arp_backend_display)

import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.geom.PointImpl;
import arpx.impl.cross.input.IInputImpl;
import arpx.impl.cross.input.InputContext;
import arpx.input.InputSource;
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

	private var context:InputContext;
	private var target:Element;

	public function new(input:LocalInput) {
		super();
		this.input = input;
	}

	public function listen(context:InputContext):Void {
		this.context = context;
		this.target = context.impl.target;
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
		this.context = null;
	}

	private function onDeactivate(event:Event):Void {
		this.input.clearStates();
	}

	private function onKeyDown(event:KeyboardEvent):Void {
		this.input.setState(InputSource.Key(event.keyCode));
		event.preventDefault();
	}

	private function onKeyUp(event:KeyboardEvent):Void {
		this.input.unsetState(InputSource.Key(event.keyCode));
		event.preventDefault();
	}

	private function onMouseMove(event:MouseEvent):Void {
		var pt:PointImpl = context.rawToWorld(event.x, event.y);
		this.input.setState(InputSource.MouseX, pt.x);
		this.input.setState(InputSource.MouseY, pt.y);
	}

	private function onMouseDown(event:MouseEvent):Void {
		this.input.setState(InputSource.MouseLeft);
	}

	private function onMouseUp(event:MouseEvent):Void {
		this.input.unsetState(InputSource.MouseLeft);
	}
}

#end
