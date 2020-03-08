package arpx.impl.cross.chip.decorators;

import arpx.chip.decorators.ColorizeParamChip;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.chip.IChipImpl;
import arpx.impl.cross.display.RenderContext;
import arpx.structs.ArpColor;
import arpx.structs.ArpParams;
import arpx.structs.IArpParamsRead;

class ColorizeParamChipImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:ColorizeParamChip;

	public function new(chip:ColorizeParamChip) {
		super();
		this.chip = chip;
	}

	public function render(context:RenderContext, params:IArpParamsRead = null):Void {
		for (kv in chip.colors.keyValueIterator()) {
			context.colors(kv.key).dup().applyMul(color(params, kv.value));
		}
		this.chip.chip.render(context, params);
		for (k in chip.colors.keys()) {
			context.colors(k).pop();
		}
	}

	private var _workColor:ArpColor = new ArpColor();
	inline private function color(params:ArpParams, key:String):ArpColor {
		var color:ArpColor = _workColor;
		color.value32 = params.getInt(key);
		return color;
	}
}

