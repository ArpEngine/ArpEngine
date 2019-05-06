package arpx.impl.cross.input.decorators;

import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.input.IInputImpl;
import arpx.input.decorators.FocusInput;

class FocusInputImpl extends ArpObjectImplBase implements IInputImpl {

	private var input:FocusInput;

	public function new(input:FocusInput) {
		super();
		this.input = input;
	}

	public function listen():Void return;
	public function purge():Void return;
}
