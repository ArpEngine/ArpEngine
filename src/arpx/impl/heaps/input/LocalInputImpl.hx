package arpx.impl.heaps.input;

#if (arp_input_backend_heaps || arp_backend_display)

import arpx.input.localInput.LocalInputSource;
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
				this.input.setState(LocalInputSource.Key(e.keyCode));
			case EKeyUp:
				this.input.unsetState(LocalInputSource.Key(e.keyCode));
			case EMove:
				this.input.setState(LocalInputSource.MouseX, e.relX);
				this.input.setState(LocalInputSource.MouseY, e.relY);
			case EPush:
				this.input.setState(LocalInputSource.MouseX, e.relX);
				this.input.setState(LocalInputSource.MouseY, e.relY);
				this.input.setState(LocalInputSource.MouseLeft);
			case ERelease:
				this.input.setState(LocalInputSource.MouseX, e.relX);
				this.input.setState(LocalInputSource.MouseY, e.relY);
				this.input.unsetState(LocalInputSource.MouseLeft);
			case EReleaseOutside:
				this.input.unsetState(LocalInputSource.MouseLeft);
			case _:
		}
	}
}

#end
