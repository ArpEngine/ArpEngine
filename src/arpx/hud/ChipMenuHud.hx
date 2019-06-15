package arpx.hud;

import arpx.chip.Chip;
import arpx.impl.cross.hud.ChipMenuHudImpl;
import arpx.input.Input;
import arpx.inputAxis.InputAxis;
import arpx.menu.Menu;
import arpx.proc.Proc;
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
				if (++this.menu.value >= this.menu.length) this.menu.value--;
			} else if (axis.value < 0) {
				if (--this.menu.value < 0) this.menu.value++;
			}
		}
		var execute:InputAxis = input.axis(this.execute);
		if (execute.isTriggerDown) {
			if (this.menu.selection != null) {
				var proc:Proc = this.menu.selection.proc;
				if (proc != null) {
					proc.execute();
				}
			}
		}
		return true;
	}
}
