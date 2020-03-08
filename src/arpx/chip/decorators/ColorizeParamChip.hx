package arpx.chip.decorators;

import arp.ds.IMap;
import arpx.impl.cross.chip.decorators.ColorizeParamChipImpl;
import arpx.impl.cross.geom.RectImpl;
import arpx.structs.IArpParamsRead;

@:arpType("chip", "tintParam")
class ColorizeParamChip extends Chip {

	@:arpField @:arpBarrier public var chip:Chip;
	@:arpField(true) public var colors:IMap<String, String>;

	@:arpImpl private var arpImpl:ColorizeParamChipImpl;

	override public function layoutSize(params:IArpParamsRead, rect:RectImpl):RectImpl return this.chip.layoutSize(params, rect);

	public function new() super();
}
