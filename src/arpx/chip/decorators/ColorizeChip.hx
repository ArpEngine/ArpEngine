package arpx.chip.decorators;

import arp.ds.IMap;
import arpx.impl.cross.chip.decorators.ColorizeChipImpl;
import arpx.impl.cross.geom.RectImpl;
import arpx.structs.ArpColor;
import arpx.structs.IArpParamsRead;

@:arpType("chip", "colorize")
class ColorizeChip extends Chip {

	@:arpField @:arpBarrier public var chip:Chip;
	@:arpField("colors", "color") public var colors:IMap<String, ArpColor>;

	@:arpImpl private var arpImpl:ColorizeChipImpl;

	override public function layoutSize(params:IArpParamsRead, rect:RectImpl):RectImpl return this.chip.layoutSize(params, rect);

	public function new() super();
}
