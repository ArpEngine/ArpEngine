package arpx.impl.sys.input.decorators;

#if (arp_input_backend_sys || arp_backend_display)

import arpx.impl.ArpObjectImplBase;
import arpx.input.decorators.FocusInput;

class FocusInputImpl extends ArpObjectImplBase implements IInputImpl {

	private var input:FocusInput;

	public function new(input:FocusInput) {
		super();
		this.input = input;
	}

	public function listen():Void return;
	public function purge():Void return;

	public function tick(timeslice:Float):Bool return true;
}

#end
