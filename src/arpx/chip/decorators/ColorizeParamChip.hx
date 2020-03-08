package arpx.chip.decorators;

import arp.ds.IMap;
import arpx.impl.cross.chip.decorators.ColorizeParamChipImpl;
import arpx.structs.ArpColor;

@:arpType("chip", "tintParam")
class ColorizeParamChip extends Chip {

	@:arpField @:arpBarrier public var chip:Chip;
	@:arpField(true) public var colors:IMap<String, ArpColor>;

	@:arpImpl private var arpImpl:ColorizeParamChipImpl;

	public function new() super();
}
