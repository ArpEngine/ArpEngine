
package arpx.impl.cross.chip.decorators;

import arpx.chip.decorators.TintParamChip;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.chip.IChipImpl;
import arpx.impl.cross.display.RenderContext;
import arpx.structs.ArpColor;
import arpx.structs.ArpParams;
import arpx.structs.IArpParamsRead;

class TintParamChipImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:TintParamChip;

	public function new(chip:TintParamChip) {
		super();
		this.chip = chip;
	}

	public function render(context:RenderContext, params:IArpParamsRead = null):Void {
		context.tints.dup().applyMul(tint(params));
		this.chip.chip.render(context, params);
		context.tints.pop();
	}

	private var _workColor:ArpColor = new ArpColor();
	inline private function tint(params:ArpParams):ArpColor {
		var color:ArpColor = _workColor;
		color.value32 = params.getInt(chip.key);
		return color;
	}
}

