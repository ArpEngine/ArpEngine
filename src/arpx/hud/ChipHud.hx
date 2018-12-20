package arpx.hud;

import arpx.chip.Chip;
import arpx.impl.cross.hud.ChipHudImpl;

@:arpType("hud", "chip")
class ChipHud extends Hud {

	@:arpBarrier @:arpField public var chip:Chip;

	@:arpImpl private var arpImpl:ChipHudImpl;

	public function new() super();
}


