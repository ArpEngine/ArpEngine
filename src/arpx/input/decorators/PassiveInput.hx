package arpx.input.decorators;

import arpx.impl.cross.input.decorators.PassiveInputImpl;
import arpx.inputAxis.InputAxis;

@:arpType("input", "passive")
class PassiveInput extends Input {

	@:arpField private var input:Input;
	@:arpField public var enabled:Bool = true;

	@:arpImpl private var arpImpl:PassiveInputImpl;

	public function new() super();

	override public function axis(button:String):InputAxis {
		return this.enabled ? this.input.axis(button) : super.axis(button);
	}
}
