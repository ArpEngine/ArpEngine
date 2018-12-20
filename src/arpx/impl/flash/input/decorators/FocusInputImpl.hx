package arpx.impl.flash.input.decorators;

#if (arp_input_backend_flash || arp_backend_display)

import flash.events.IEventDispatcher;
import arpx.impl.ArpObjectImplBase;
import arpx.input.decorators.FocusInput;

class FocusInputImpl extends ArpObjectImplBase implements IInputImpl {

	private var input:FocusInput;

	public function new(input:FocusInput) {
		super();
		this.input = input;
	}

	public function listen(target:IEventDispatcher):Void return;
	public function purge():Void return;
}

#end
