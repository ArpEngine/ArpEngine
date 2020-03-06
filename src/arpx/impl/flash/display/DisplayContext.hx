package arpx.impl.flash.display;

#if (arp_display_backend_flash || arp_backend_display)

import flash.display.BitmapData;

import arpx.impl.cross.structs.ArpTransform;
import arpx.structs.ArpColor;

@:forward(
	bitmapData,
	width, height, clearColor,
	renderContext
)
abstract DisplayContext(DisplayContextImpl) {
	inline public function new(bitmapData:BitmapData, transform:ArpTransform = null, clearColor:ArpColor = null) {
		this = new DisplayContextImpl(bitmapData, transform, clearColor);
	}
}

#end



