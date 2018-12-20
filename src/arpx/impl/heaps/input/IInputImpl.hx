package arpx.impl.heaps.input;

#if (arp_input_backend_heaps || arp_backend_display)

import arp.impl.IArpObjectImpl;

interface IInputImpl extends IArpObjectImpl {
	function listen():Void;
	function purge():Void;
}

#end
