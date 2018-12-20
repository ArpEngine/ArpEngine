package arpx.impl.stub.display;

#if (arp_display_backend_stub || arp_backend_display)

@:forward(
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
