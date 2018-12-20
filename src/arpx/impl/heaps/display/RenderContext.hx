package arpx.impl.heaps.display;

#if (arp_display_backend_heaps || arp_backend_display)

@:forward(
	buf, drawTile,
	width, height, clearColor,
	display, transform, dupTransform, popTransform, fillRect
)
abstract RenderContext(DisplayContextImpl) {
	inline public function new(impl:DisplayContextImpl) {
		this = impl;
		this.start();
	}
}

#end
