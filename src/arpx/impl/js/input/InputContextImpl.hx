package arpx.impl.js.input;

#if arp_input_backend_js

import js.html.Element;

class InputContextImpl {

	public var target:Element;

	public function new(target:Element) {
		this.target = target;
	}
}

#end
