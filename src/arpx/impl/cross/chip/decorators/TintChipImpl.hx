package arpx.impl.cross.chip.decorators;

import arpx.chip.decorators.TintChip;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.chip.IChipImpl;
import arpx.impl.cross.display.RenderContext;
import arpx.structs.IArpParamsRead;

class TintChipImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:TintChip;

	public function new(chip:TintChip) {
		super();
		this.chip = chip;
	}

	public function render(context:RenderContext, params:IArpParamsRead = null):Void {
		context.tints.dup().applyMul(chip.color);
		this.chip.chip.render(context, params);
		context.tints.pop();
	}
}

