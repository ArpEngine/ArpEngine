package arpx.impl.cross.input.decorators;

import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.input.IInputImpl;
import arpx.impl.cross.input.InputContext;
import arpx.input.decorators.PassiveInput;

class PassiveInputImpl extends ArpObjectImplBase implements IInputImpl {

	private var input:PassiveInput;

	public function new(input:PassiveInput) {
		super();
		this.input = input;
	}

	public function listen(context:InputContext):Void return;
	public function purge():Void return;
}
