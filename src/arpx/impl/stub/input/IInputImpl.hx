package arpx.impl.stub.input;

#if (arp_input_backend_stub || arp_backend_display)

import arp.impl.IArpObjectImpl;
import arp.task.ITickable;

interface IInputImpl extends IArpObjectImpl extends ITickable {
	function listen():Void;
	function purge():Void;
	function tick(timeslice:Float):Bool;
}

#end
