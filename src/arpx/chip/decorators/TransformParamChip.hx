package arpx.chip.decorators;

import arpx.impl.cross.chip.decorators.TransformParamChipImpl;
import arpx.impl.cross.geom.RectImpl;
import arpx.impl.cross.structs.ArpTransform;
import arpx.paramsOp.ParamsOp;
import arpx.structs.IArpParamsRead;

@:arpType("chip", "transformParam")
class TransformParamChip extends Chip {

	@:arpField @:arpBarrier public var chip:Chip;
	@:arpField public var transform:ArpTransform;
	@:arpField public var paramsOp:ParamsOp;

	@:arpImpl private var arpImpl:TransformParamChipImpl;

	override public function layoutSize(params:IArpParamsRead, rect:RectImpl):RectImpl {
		chip.layoutSize(params, rect);
		rect.transform(@:privateAccess TransformParamChipImpl.transform(params, paramsOp).impl);
		return rect;
	}

	public function new() super();
}
