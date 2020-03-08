package arpx.chip.decorators;

import arpx.impl.cross.chip.decorators.TransformChipImpl;
import arpx.impl.cross.geom.RectImpl;
import arpx.impl.cross.structs.ArpTransform;
import arpx.structs.IArpParamsRead;

@:arpType("chip", "transform")
class TransformChip extends Chip {

	@:arpField @:arpBarrier public var chip:Chip;
	@:arpField public var transform:ArpTransform;

	@:arpImpl private var flashImpl:TransformChipImpl;

	override public function layoutSize(params:IArpParamsRead, rect:RectImpl):RectImpl {
		chip.layoutSize(params, rect);
		rect.transform(transform.impl);
		return rect;
	}

	public function new() super();
}
