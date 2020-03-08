package arpx.chip.decorators;

import arpx.impl.cross.chip.decorators.TintParamChipImpl;
import arpx.impl.cross.geom.RectImpl;
import arpx.structs.IArpParamsRead;

@:arpType("chip", "tintParam")
class TintParamChip extends Chip {

	@:arpField @:arpBarrier public var chip:Chip;
	@:arpField public var key:String = "tint";

	@:arpImpl private var arpImpl:TintParamChipImpl;

	override public function layoutSize(params:IArpParamsRead, rect:RectImpl):RectImpl return this.chip.layoutSize(params, rect);

	public function new() super();
}
