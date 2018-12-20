package arpx.impl.flash.input.decorators;

#if (arp_input_backend_flash || arp_backend_display)

import flash.events.IEventDispatcher;
import arpx.impl.ArpObjectImplBase;
import arpx.input.decorators.PassiveInput;

class PassiveInputImpl extends ArpObjectImplBase implements IInputImpl {

	private var input:PassiveInput;

	public function new(input:PassiveInput) {
		super();
		this.input = input;
	}

	public function listen(target:IEventDispatcher):Void return;
	public function purge():Void return;
}

#end
