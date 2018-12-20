package arpx.impl.cross.chip;

import arpx.chip.stringChip.StringChipTypeset;
import arpx.chip.StringChip;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.display.RenderContext;
import arpx.impl.cross.geom.PointImpl;
import arpx.structs.IArpParamsRead;

class StringChipImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:StringChip;

	public function new(chip:StringChip) {
		super();
		this.chip = chip;
	}

	private var _workPt:PointImpl = PointImpl.alloc();
	public function render(context:RenderContext, params:IArpParamsRead = null):Void {
		for (char in StringChipTypeset.cached(this.chip, params)) {
			char.renderChar(context);
		}
	}
}
