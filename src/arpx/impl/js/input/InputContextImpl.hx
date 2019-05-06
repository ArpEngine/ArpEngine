package arpx.impl.js.input;

#if (arp_input_backend_js || arp_backend_display)

import js.html.Element;

class InputContextImpl {

	public var target:Element;

	public function new(target:Element) {
		this.target = target;
	}
}

#end
