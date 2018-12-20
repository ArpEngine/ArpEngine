package arpx.chip;

import arpx.impl.cross.geom.RectImpl;
import arpx.impl.cross.chip.TextureChipImpl;
import arpx.structs.ArpColor;
import arpx.structs.IArpParamsRead;
import arpx.texture.Texture;

@:arpType("chip", "texture")
class TextureChip extends Chip {

	@:arpBarrier(true) @:arpField public var texture:Texture;
	@:arpField public var color:ArpColor = new ArpColor(0xffffffff);
	@:arpField public var baseX:Int;
	@:arpField public var baseY:Int;

	override public function layoutSize(params:IArpParamsRead, rect:RectImpl):RectImpl {
		this.texture.layoutSize(params, rect).translateXY(this.baseX, this.baseY);
		return rect;
	}

	@:arpImpl private var arpImpl:TextureChipImpl;

	public function new() super();
}


