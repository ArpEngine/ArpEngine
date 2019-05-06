package arpx.impl.stub.input;

#if (arp_input_backend_stub || arp_backend_display)

import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.input.IInputImpl;
import arpx.input.LocalInput;

class LocalInputImpl extends ArpObjectImplBase implements IInputImpl {

	private var input:LocalInput;

	public function new(input:LocalInput) {
		super();
		this.input = input;
	}

	public function listen():Void return;
	public function purge():Void return;
}

#end
