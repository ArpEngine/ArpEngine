package arpx.impl.cross.input;

import arp.impl.IArpObjectImpl;
import arpx.impl.cross.input.InputContext;

interface IInputImpl extends IArpObjectImpl {
	function listen(context:InputContext):Void;
	function purge():Void;
}
