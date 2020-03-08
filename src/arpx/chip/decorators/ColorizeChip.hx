package arpx.chip.decorators;

import arp.ds.IMap;
import arpx.impl.cross.chip.decorators.ColorizeChipImpl;

@:arpType("chip", "colorize")
class ColorizeChip extends Chip {

	@:arpField @:arpBarrier public var chip:Chip;
	@:arpField(true) public var keys:IMap<String, String>;

	@:arpImpl private var arpImpl:ColorizeChipImpl;

	public function new() super();
}
