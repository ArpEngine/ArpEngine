package arpx.impl.flash.input;

#if (arp_input_backend_flash || arp_backend_display)

import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.input.IInputImpl;
import arpx.impl.cross.input.InputContext;
import arpx.input.localInput.LocalInputSource;
import arpx.input.LocalInput;
import flash.events.Event;
import flash.events.IEventDispatcher;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;

class LocalInputImpl extends ArpObjectImplBase implements IInputImpl {

	private var input:LocalInput;
	private var target:IEventDispatcher;

	public function new(input:LocalInput) {
		super();
		this.input = input;
	}

	public function listen(context:InputContext):Void {
		this.target = context.impl.target;
		this.target.addEventListener(Event.DEACTIVATE, this.onDeactivate);
		this.target.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
		this.target.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
		this.target.addEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
		this.target.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
		this.target.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
	}

	public function purge():Void {
		this.target.removeEventListener(Event.DEACTIVATE, this.onDeactivate);
		this.target.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
		this.target.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
		this.target.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
		this.target.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
		this.target.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
		this.target = null;
	}

	private function onDeactivate(event:Event):Void {
		this.input.clear();
	}

	private function onKeyDown(event:KeyboardEvent):Void {
		this.input.setState(LocalInputSource.Key(event.keyCode));
	}

	private function onKeyUp(event:KeyboardEvent):Void {
		this.input.unsetState(LocalInputSource.Key(event.keyCode));
	}

	private function onMouseMove(event:MouseEvent):Void {
		this.input.setState(LocalInputSource.MouseX, event.stageX);
		this.input.setState(LocalInputSource.MouseY, event.stageY);
	}

	private function onMouseDown(event:MouseEvent):Void {
		this.input.setState(LocalInputSource.MouseLeft);
	}

	private function onMouseUp(event:MouseEvent):Void {
		this.input.unsetState(LocalInputSource.MouseLeft);
	}
}

#end
