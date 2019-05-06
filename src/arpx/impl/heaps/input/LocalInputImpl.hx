package arpx.impl.heaps.input;

#if (arp_input_backend_heaps || arp_backend_display)

import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.input.IInputImpl;
import arpx.input.LocalInput;
import hxd.Event;
import hxd.Window;

class LocalInputImpl extends ArpObjectImplBase implements IInputImpl {

	private var input:LocalInput;

	private var target:Window;

	public function new(input:LocalInput) {
		super();
		this.input = input;
	}

	public function listen():Void {
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
			case EMove:
				@:privateAccess this.input.mouseX = e.relX;
				@:privateAccess this.input.mouseY = e.relY;
			case EPush:
				@:privateAccess this.input.mouseX = e.relX;
				@:privateAccess this.input.mouseY = e.relY;
				@:privateAccess this.input.mouseLeft = true;
			case ERelease:
				@:privateAccess this.input.mouseX = e.relX;
				@:privateAccess this.input.mouseY = e.relY;
				@:privateAccess this.input.mouseLeft = false;
			case EReleaseOutside:
				@:privateAccess this.input.mouseLeft = false;
			case _:
		}
	}
}

#end
