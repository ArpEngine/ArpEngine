package arpx.hud;

import arpx.chip.Chip;
import arpx.impl.cross.hud.ChipMenuHudImpl;
import arpx.input.Input;
import arpx.inputAxis.InputAxis;
import arpx.menu.Menu;
import arpx.structs.ArpPosition;

@:arpType("hud", "chipMenu")
class ChipMenuHud extends Hud {

	@:arpBarrier @:arpField public var chip:Chip;
	@:arpField public var dPosition:ArpPosition;
	@:arpField public var axis:String = "y";
	@:arpField public var execute:String = "s";
	@:arpBarrier @:arpField public var menu:Menu;

	@:arpImpl private var arpImpl:ChipMenuHudImpl;

	public function new() {
		super();
	}

	override public function interact(input:Input):Bool {
		var axis:InputAxis = input.axis(this.axis);
		if (axis.isTrigger) {
			if (axis.value > 0) {
				this.menu.shift(1);
			} else if (axis.value < 0) {
				this.menu.shift(-1);
			}
		}
		var execute:InputAxis = input.axis(this.execute);
		if (execute.isTriggerDown) {
			this.menu.executeSelection();
		}
		return true;
	}
}
