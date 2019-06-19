package arpx.impl.heaps.input;

#if (arp_input_backend_heaps || arp_backend_display)

import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.geom.PointImpl;
import arpx.impl.cross.input.IInputImpl;
import arpx.impl.cross.input.InputContext;
import arpx.input.InputSource;
import arpx.input.LocalInput;
import hxd.Event;
import hxd.Window;

class LocalInputImpl extends ArpObjectImplBase implements IInputImpl {

	private var input:LocalInput;

	private var context:InputContext;
	private var target:Window;

	public function new(input:LocalInput) {
		super();
		this.input = input;
	}

	public function listen(context:InputContext):Void {
		this.context = context;
		this.target = Window.getInstance();
		this.target.addEventTarget(onEvent);
	}

	public function purge():Void {
		this.target.removeEventTarget(onEvent);
		this.target = null;
		this.context = null;
	}

	private function readMousePosition(e:Event):Void {
		var pt:PointImpl = context.rawToWorld(e.relX, e.relY);
		this.input.setState(InputSource.MouseX, pt.x);
		this.input.setState(InputSource.MouseY, pt.y);
	}

	private function onEvent(e:Event):Void {
		switch( e.kind ) {
			case EKeyDown:
				this.input.setState(InputSource.Key(e.keyCode));
			case EKeyUp:
				this.input.unsetState(InputSource.Key(e.keyCode));
			case EMove:
				readMousePosition(e);
			case EPush:
				readMousePosition(e);
				this.input.setState(InputSource.MouseLeft);
			case ERelease:
				readMousePosition(e);
				this.input.unsetState(InputSource.MouseLeft);
			case EReleaseOutside:
				this.input.unsetState(InputSource.MouseLeft);
			case _:
		}
	}
}

#end
