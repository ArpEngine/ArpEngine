package arpx.chip;

import arpx.impl.cross.geom.RectImpl;
import arpx.impl.cross.chip.NativeTextChipImpl;
import arpx.structs.ArpColor;
import arpx.structs.IArpParamsRead;

@:arpType("chip", "nativeText")
class NativeTextChip extends Chip {

	@:arpField public var chipWidth:Float = 100;
	@:arpField public var chipHeight:Float = 100;

	@:arpField public var font:String = "_sans";
	@:arpField public var fontSize:Int = 12;
	@:arpField public var color:ArpColor = new ArpColor(0xff000000);

	override public function layoutSize(params:IArpParamsRead, rect:RectImpl):RectImpl {
		rect.reset(0, 0, chipWidth, chipHeight);
		return rect;
	}

	@:arpImpl private var arpImpl:NativeTextChipImpl;

	public function new() super();
}


