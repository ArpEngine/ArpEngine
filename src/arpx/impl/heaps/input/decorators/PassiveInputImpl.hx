package arpx.impl.heaps.input.decorators;

#if (arp_input_backend_heaps || arp_backend_display)

import arpx.impl.ArpObjectImplBase;
import arpx.input.decorators.PassiveInput;

class PassiveInputImpl extends ArpObjectImplBase implements IInputImpl {

	private var input:PassiveInput;

	public function new(input:PassiveInput) {
		super();
		this.input = input;
	}

	public function listen():Void return;
	public function purge():Void return;
}

#end
