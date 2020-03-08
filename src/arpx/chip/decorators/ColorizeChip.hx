package arpx.chip.decorators;

import arpx.structs.ArpColor;
import arp.ds.IMap;
import arpx.impl.cross.chip.decorators.ColorizeChipImpl;

@:arpType("chip", "colorize")
class ColorizeChip extends Chip {

	@:arpField @:arpBarrier public var chip:Chip;
	@:arpField("colors", "color") public var colors:IMap<String, ArpColor>;

	@:arpImpl private var arpImpl:ColorizeChipImpl;

	public function new() super();
}
