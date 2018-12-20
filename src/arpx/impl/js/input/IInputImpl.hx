package arpx.impl.js.input;

#if (arp_input_backend_js || arp_backend_display)

import js.html.Element;

import arp.impl.IArpObjectImpl;

interface IInputImpl extends IArpObjectImpl {
	function listen(target:Element):Void;
	function purge():Void;
}

#end
