package arpx.chip.decorators;

import arpx.impl.cross.chip.decorators.TintParamChipImpl;

@:arpType("chip", "tintParam")
class TintParamChip extends Chip {

	@:arpField @:arpBarrier public var chip:Chip;
	@:arpField public var key:String = "tint";

	@:arpImpl private var arpImpl:TintParamChipImpl;

	public function new() super();
}
