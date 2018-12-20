package arpx.chip.stringChip;

import arpx.impl.cross.display.RenderContext;
import arpx.impl.cross.geom.RectImpl;
import arpx.structs.ArpParams;

class StringChipTypesetChar {

	public var typeset:StringChipTypeset;
	public var dX:Float = 0;
	public var dY:Float = 0;
	public var char:String;

	public function new(typeset:StringChipTypeset, dX:Float, dY:Float, char:String) {
		this.typeset = typeset;
		this.dX = dX;
		this.dY = dY;
		this.char = char;
	}

	public function renderChar(context:RenderContext):Void {
		if (Math.isNaN(dX)) return;
		var params:ArpParams = @:privateAccess this.typeset.font.charParams;

		context.dupTransform();
		context.transform.prependXY(this.dX, this.dY);
		params.set("face", this.char);
		@:privateAccess this.typeset.font.chip.render(context, params);
		context.popTransform();
	}

	public function layoutChar(rect:RectImpl):RectImpl {
		if (Math.isNaN(dX)) return rect;
		@:privateAccess rect.copyFrom(this.typeset.font.chipSize.get(this.char));
		rect.translateXY(this.dX, this.dY);
		return rect;
	}
}

