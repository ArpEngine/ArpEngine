package arpx.chip.decorators;

import arpx.impl.cross.chip.decorators.FilterChipImpl;
import arpx.impl.cross.geom.RectImpl;
import arpx.paramsOp.ParamsOp;
import arpx.structs.IArpParamsRead;

@:arpType("chip", "filter")
class FilterChip extends Chip {

	@:arpField @:arpBarrier public var chip:Chip;
	@:arpField @:arpBarrier public var paramsOp:ParamsOp;

	@:arpImpl private var arpImpl:FilterChipImpl;

	override public function layoutSize(params:IArpParamsRead, rect:RectImpl):RectImpl return chip.layoutSize(params, rect);

	public function new() super();
}
