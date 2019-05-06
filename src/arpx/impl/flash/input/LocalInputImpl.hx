package arpx.impl.flash.input;

#if (arp_input_backend_flash || arp_backend_display)

import flash.events.MouseEvent;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.input.IInputImpl;
import arpx.impl.cross.input.InputContext;
import arpx.input.LocalInput;
import flash.events.Event;
import flash.events.IEventDispatcher;
import flash.events.KeyboardEvent;

class LocalInputImpl extends ArpObjectImplBase implements IInputImpl {

	private var input:LocalInput;
	private var target:IEventDispatcher;

	public function new(input:LocalInput) {
		super();
		this.input = input;
	}

	public function listen():Void {
		this.target = InputContext.instance.impl.target;
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
		@:privateAccess this.input.keyStates.set(event.keyCode, true);
	}

	private function onKeyUp(event:KeyboardEvent):Void {
		@:privateAccess this.input.keyStates.set(event.keyCode, false);
	}

	private function onMouseMove(event:MouseEvent):Void {
		@:privateAccess this.input.mouseX = event.stageX;
		@:privateAccess this.input.mouseY = event.stageY;
	}

	private function onMouseDown(event:MouseEvent):Void {
		@:privateAccess this.input.mouseLeft = true;
	}

	private function onMouseUp(event:MouseEvent):Void {
		@:privateAccess this.input.mouseLeft = false;
	}
}

#end
