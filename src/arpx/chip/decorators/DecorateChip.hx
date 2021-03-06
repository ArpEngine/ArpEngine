package arpx.chip.decorators;

import arp.ds.IMap;
import arpx.impl.cross.chip.decorators.DecorateChipImpl;
import arpx.impl.cross.geom.RectImpl;
import arpx.impl.cross.structs.ArpTransform;
import arpx.paramsOp.ParamsOp;
import arpx.structs.ArpColor;
import arpx.structs.IArpParamsRead;

@:arpType("chip", "decorate")
class DecorateChip extends Chip {

	@:arpField @:arpBarrier public var chip:Chip;
	@:arpField @:arpBarrier public var paramsOp:ParamsOp;
	@:arpField public var transform:ArpTransform;
	@:arpField(true) public var colors:IMap<String, ArpColor>;

	@:arpImpl private var arpImpl:DecorateChipImpl;

	override public function layoutSize(params:IArpParamsRead, rect:RectImpl):RectImpl {
		chip.layoutSize(params, rect);
		rect.transform(transform.impl);
		return rect;
	}

	public function new() super();
}
