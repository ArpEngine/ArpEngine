package arpx.impl.stub.input;

#if (arp_input_backend_stub || arp_backend_display)

import arpx.impl.ArpObjectImplBase;
import arpx.input.KeyInput;

class KeyInputImpl extends ArpObjectImplBase implements IInputImpl {

	private var input:KeyInput;

	public function new(input:KeyInput) {
		super();
		this.input = input;
	}

	public function listen():Void return;
	public function purge():Void return;
	public function tick(timeslice:Float):Bool return true;

}

#end
