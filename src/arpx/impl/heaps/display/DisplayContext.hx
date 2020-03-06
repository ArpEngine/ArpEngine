package arpx.impl.heaps.display;

#if (arp_display_backend_heaps || arp_backend_display)

import h2d.Object;

import arpx.impl.cross.structs.ArpTransform;
import arpx.structs.ArpColor;

@:forward(
	buf, drawTile,
	width, height, clearColor,
	renderContext
)
abstract DisplayContext(DisplayContextImpl) {
	inline public function new(buf:Object, width:Int, height:Int, transform:ArpTransform = null, clearColor:ArpColor = null) {
		this = new DisplayContextImpl(buf, width, height, transform, clearColor);
	}
}

#end
