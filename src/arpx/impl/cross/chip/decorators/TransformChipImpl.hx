package arpx.impl.cross.chip.decorators;

import arpx.chip.decorators.TransformChip;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.chip.IChipImpl;
import arpx.impl.cross.display.RenderContext;
import arpx.structs.IArpParamsRead;

class TransformChipImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:TransformChip;

	public function new(chip:TransformChip) {
		super();
		this.chip = chip;
	}

	public function render(context:RenderContext, params:IArpParamsRead = null):Void {
		context.dupTransform().prependTransform(chip.transform);
		this.chip.chip.render(context, params);
		context.popTransform();
	}
}

