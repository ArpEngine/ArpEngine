package arpx.impl.heaps.input;

#if (arp_input_backend_heaps || arp_backend_display)

import arpx.impl.cross.input.InputContext;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.input.IInputImpl;
import arpx.input.KeyInput;
import hxd.Event;
import hxd.Window;

class KeyInputImpl extends ArpObjectImplBase implements IInputImpl {

	private var input:KeyInput;

	private var target:Window;

	public function new(input:KeyInput) {
		super();
		this.input = input;
	}

	public function listen(context:InputContext):Void {
		this.target = Window.getInstance();
		this.target.addEventTarget(onEvent);
	}

	public function purge():Void {
		this.target.removeEventTarget(onEvent);
		this.target = null;
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
