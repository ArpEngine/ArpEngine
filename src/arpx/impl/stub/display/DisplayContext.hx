package arpx.impl.stub.display;

#if (arp_display_backend_stub || arp_backend_display)

import arpx.impl.cross.structs.ArpTransform;

@:forward(
	width, height, clearColor,
	renderContext
)
abstract DisplayContext(DisplayContextImpl) {
	inline public function new(width:Int, height:Int, transform:ArpTransform = null, clearColor:UInt = 0xff000000) {
		this = new DisplayContextImpl(width, height, transform, clearColor);
	}
}

#end
