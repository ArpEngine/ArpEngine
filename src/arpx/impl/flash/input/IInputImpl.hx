package arpx.impl.flash.input;

#if (arp_input_backend_flash || arp_backend_display)

import flash.events.IEventDispatcher;
import arp.impl.IArpObjectImpl;

interface IInputImpl extends IArpObjectImpl {
	function listen(target:IEventDispatcher):Void;
	function purge():Void;
}

#end
