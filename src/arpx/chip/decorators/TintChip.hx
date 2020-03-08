package arpx.chip.decorators;

import arpx.impl.cross.chip.decorators.TintChipImpl;
import arpx.structs.ArpColor;

@:arpType("chip", "tint")
class TintChip extends Chip {

	@:arpField @:arpBarrier public var chip:Chip;
	@:arpField public var color:ArpColor;

	@:arpImpl private var arpImpl:TintChipImpl;

	public function new() super();
}
