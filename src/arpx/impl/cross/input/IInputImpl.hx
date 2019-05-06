package arpx.impl.cross.input;

import arp.impl.IArpObjectImpl;

interface IInputImpl extends IArpObjectImpl {
	function listen():Void;
	function purge():Void;
}
