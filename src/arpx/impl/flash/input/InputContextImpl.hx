package arpx.impl.flash.input;

#if (arp_input_backend_flash || arp_backend_display)

import flash.events.IEventDispatcher;

class InputContextImpl {

	public var target:IEventDispatcher;

	public function new(target:IEventDispatcher) {
		this.target = target;
	}
}

#end
