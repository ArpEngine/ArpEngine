package arpx.impl.heaps.input;

#if (arp_input_backend_heaps || arp_backend_display)

import hxd.Event;
import hxd.Window;
import arpx.impl.ArpObjectImplBase;
import arpx.input.KeyInput;

class KeyInputImpl extends ArpObjectImplBase implements IInputImpl {

	private var input:KeyInput;

	public function new(input:KeyInput) {
		super();
		this.input = input;
	}

	public function listen():Void {
		Window.getInstance().addEventTarget(onEvent);
	}

	public function purge():Void {
		Window.getInstance().removeEventTarget(onEvent);
	}

	private function onEvent(e:Event):Void {
		switch( e.kind ) {
			case EKeyDown:
				@:privateAccess this.input.keyStates.set(e.keyCode, true);
			case EKeyUp:
				@:privateAccess this.input.keyStates.set(e.keyCode, false);
			case _:
		}
	}
}

#end
