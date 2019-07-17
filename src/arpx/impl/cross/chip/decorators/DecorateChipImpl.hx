package arpx.impl.cross.chip.decorators;

import arpx.chip.decorators.DecorateChip;
import arpx.impl.cross.display.RenderContext;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.chip.IChipImpl;
import arpx.structs.IArpParamsRead;

class DecorateChipImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:DecorateChip;

	public function new(chip:DecorateChip) {
		super();
		this.chip = chip;
	}

	override public function arpHeatUpNow():Bool {
		return true;
	}

	override public function arpHeatDownNow():Bool {
		return true;
	}

	public function render(context:RenderContext, params:IArpParamsRead = null):Void {
		var p:IArpParamsRead = params;
		if (this.chip.paramsOp != null) {
			p = this.chip.paramsOp.filter(p);
		}
		context.dupTransform().prependTransform(chip.transform);
		this.chip.chip.render(context, p);
		context.popTransform();
	}
}

