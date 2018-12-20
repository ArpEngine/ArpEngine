package arpx.impl.js.input.decorators;

#if (arp_input_backend_js || arp_backend_display)

import js.html.Element;

import arpx.impl.ArpObjectImplBase;
import arpx.input.decorators.PassiveInput;

class PassiveInputImpl extends ArpObjectImplBase implements IInputImpl {

	private var input:PassiveInput;

	public function new(input:PassiveInput) {
		super();
		this.input = input;
	}

	public function listen(target:Element):Void return;
	public function purge():Void return;
}

#end
