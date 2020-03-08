package arpx.impl.cross.chip.decorators;

import arpx.chip.decorators.ColorizeChip;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.chip.IChipImpl;
import arpx.impl.cross.display.RenderContext;
import arpx.structs.IArpParamsRead;

class ColorizeChipImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:ColorizeChip;

	public function new(chip:ColorizeChip) {
		super();
		this.chip = chip;
	}

	public function render(context:RenderContext, params:IArpParamsRead = null):Void {
		for (kv in chip.colors.keyValueIterator()) {
			context.colors(kv.key).dup().applyMul(kv.value);
		}
		this.chip.chip.render(context, params);
		for (k in chip.colors.keys()) {
			context.colors(k).pop();
		}
	}
}

