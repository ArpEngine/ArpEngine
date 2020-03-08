package arpx.chip.decorators;

import arpx.impl.cross.chip.decorators.TintChipImpl;
import arpx.impl.cross.geom.RectImpl;
import arpx.structs.ArpColor;
import arpx.structs.IArpParamsRead;

@:arpType("chip", "tint")
class TintChip extends Chip {

	@:arpField @:arpBarrier public var chip:Chip;
	@:arpField public var color:ArpColor;

	@:arpImpl private var arpImpl:TintChipImpl;

	override public function layoutSize(params:IArpParamsRead, rect:RectImpl):RectImpl return this.chip.layoutSize(params, rect);

	public function new() super();
}
