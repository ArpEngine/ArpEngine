package arpx.impl.flash.display;

#if (arp_display_backend_flash || arp_backend_display)

import flash.display.BitmapData;

import arpx.impl.cross.structs.ArpTransform;

@:forward(
	bitmapData,
	width, height, clearColor,
	renderContext
)
abstract DisplayContext(DisplayContextImpl) {
	inline public function new(bitmapData:BitmapData, transform:ArpTransform = null, clearColor:UInt = 0xff000000) {
		this = new DisplayContextImpl(bitmapData, transform, clearColor);
	}
}

#end



