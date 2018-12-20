package arpx.chip;

import arpx.impl.cross.chip.RectChipImpl;
import arpx.impl.cross.geom.RectImpl;
import arpx.structs.ArpColor;
import arpx.structs.IArpParamsRead;

@:arpType("chip", "rect")
class RectChip extends Chip {

	@:arpField public var baseX:Int;
	@:arpField public var baseY:Int;
	@:arpField public var chipWidth:Float;
	@:arpField public var chipHeight:Float;
	@:arpField public var color:ArpColor;
	@:arpField public var border:ArpColor;

	override public function layoutSize(params:IArpParamsRead, rect:RectImpl):RectImpl {
		rect.reset(baseX, baseY, chipWidth, chipHeight);
		return rect;
	}

	@:arpImpl private var arpImpl:RectChipImpl;

	public function new () super();
}
