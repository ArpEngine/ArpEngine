package arpx.impl.cross.chip;

import arpx.chip.RectChip;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.chip.IChipImpl;
import arpx.impl.cross.display.RenderContext;
import arpx.impl.cross.geom.PointImpl;
import arpx.structs.IArpParamsRead;
import arpx.structs.ArpColor;

class RectChipImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:RectChip;

	public function new(chip:RectChip) {
		super();
		this.chip = chip;
	}

	private var _workPt:PointImpl = PointImpl.alloc();
	public function render(context:RenderContext, params:IArpParamsRead = null):Void {
		var l:Int = -chip.baseX;
		var t:Int = -chip.baseY;
		var w:Int = Std.int(chip.chipWidth);
		var h:Int = Std.int(chip.chipHeight);
		context.tints.dup().applyMul(chip.border);
		context.fillRect(l, t, w, 1);
		context.fillRect(l, t + h - 1, w, 1);
		t++;
		h -= 2;
		context.fillRect(l, t, 1, h);
		context.fillRect(l + w - 1, t, 1, h);
		context.tints.pop();
		context.tints.dup().applyMul(chip.color);
		context.fillRect(++l, t, w - 2, h);
		context.tints.pop();
	}
}
