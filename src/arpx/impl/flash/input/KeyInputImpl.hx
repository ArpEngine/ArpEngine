package arpx.impl.flash.input;

#if (arp_input_backend_flash || arp_backend_display)

import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.input.IInputImpl;
import arpx.impl.cross.input.InputContext;
import arpx.input.InputSource;
import arpx.input.KeyInput;
import flash.events.Event;
import flash.events.IEventDispatcher;
import flash.events.KeyboardEvent;

class KeyInputImpl extends ArpObjectImplBase implements IInputImpl {

	private var input:KeyInput;
	private var target:IEventDispatcher;

	public function new(input:KeyInput) {
		super();
		this.input = input;
	}

	public function listen(context:InputContext):Void {
		this.target = context.impl.target;
		this.target.addEventListener(Event.DEACTIVATE, this.onDeactivate);
		this.target.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
		this.target.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
	}

	public function purge():Void {
		this.target.removeEventListener(Event.DEACTIVATE, this.onDeactivate);
		this.target.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
		this.target.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
		this.target = null;
	}

	private function onDeactivate(event:Event):Void {
		this.input.clear();
	}

	private function onKeyDown(event:KeyboardEvent):Void {
		this.input.setState(InputSource.Key(event.keyCode));
	}

	private function onKeyUp(event:KeyboardEvent):Void {
		this.input.unsetState(InputSource.Key(event.keyCode));
	}
}

#end
