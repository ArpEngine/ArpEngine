package arpx.impl.flash.display;

#if (arp_display_backend_flash || arp_backend_display)

@:forward(
	bitmapData,
	width, height, clearColor,
	display,
	transform, dupTransform, popTransform,
	tint, tints, colors,
	focus, pushFocus, popFocus,
	fillRect, fillFace
)
abstract RenderContext(DisplayContextImpl) {
	inline public function new(impl:DisplayContextImpl) {
		this = impl;
		this.start();
	}
}

#end



