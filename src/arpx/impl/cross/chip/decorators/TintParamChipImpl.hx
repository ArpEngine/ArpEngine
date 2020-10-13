
package arpx.impl.cross.chip.decorators;

import arpx.chip.decorators.TintParamChip;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.chip.IChipImpl;
import arpx.impl.cross.display.RenderContext;
import arpx.structs.ArpColor;
import arpx.structs.IArpParamsRead;

class TintParamChipImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:TintParamChip;

	public function new(chip:TintParamChip) {
		super();
		this.chip = chip;
	}

	public function render(context:RenderContext, params:IArpParamsRead = null):Void {
		context.tints.dup().applyMul(color(params, chip.paramsKey));
		this.chip.chip.render(context, params);
		context.tints.pop();
	}

	private var _white:ArpColor = ArpColor.WHITE;
	inline private function color(params:IArpParamsRead, key:String):ArpColor {
		return params.getArpColorOrDefault(key, _white);
	}
}

