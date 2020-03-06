package arpx.impl.stub.display;

#if (arp_display_backend_stub || arp_backend_display)

import arpx.impl.cross.structs.ArpTransform;
import arpx.structs.ArpColor;

@:forward(
	width, height, clearColor,
	renderContext
)
abstract DisplayContext(DisplayContextImpl) {
	inline public function new(width:Int, height:Int, transform:ArpTransform = null, clearColor:ArpColor = null) {
		this = new DisplayContextImpl(width, height, transform, clearColor);
	}
}

#end
