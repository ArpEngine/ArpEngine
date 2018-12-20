package arpx.impl.heaps.display;

#if (arp_display_backend_heaps || arp_backend_display)

import h2d.Object;

import arpx.impl.cross.structs.ArpTransform;

@:forward(
	buf, drawTile,
	width, height, clearColor,
	renderContext
)
abstract DisplayContext(DisplayContextImpl) {
	inline public function new(buf:Object, width:Int, height:Int, transform:ArpTransform = null, clearColor:UInt = 0) {
		this = new DisplayContextImpl(buf, width, height, transform, clearColor);
	}
}

#end
