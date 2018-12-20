package arpx.impl.js.input.decorators;

#if (arp_input_backend_js || arp_backend_display)

import js.html.Element;

import arpx.impl.ArpObjectImplBase;
import arpx.input.decorators.FocusInput;

class FocusInputImpl extends ArpObjectImplBase implements IInputImpl {

	private var input:FocusInput;

	public function new(input:FocusInput) {
		super();
		this.input = input;
	}

	public function listen(target:Element):Void return;
	public function purge():Void return;
}

#end
