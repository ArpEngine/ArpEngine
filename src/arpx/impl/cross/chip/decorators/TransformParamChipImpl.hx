package arpx.impl.cross.chip.decorators;

import arpx.paramsOp.ParamsOp;
import arpx.chip.decorators.TransformParamChip;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.chip.IChipImpl;
import arpx.impl.cross.display.RenderContext;
import arpx.impl.cross.structs.ArpTransform;
import arpx.structs.IArpParamsRead;

class TransformParamChipImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:TransformParamChip;

	public function new(chip:TransformParamChip) {
		super();
		this.chip = chip;
	}

	public function render(context:RenderContext, params:IArpParamsRead = null):Void {
		context.dupTransform().prependTransform(transform(params, chip.paramsOp));
		this.chip.chip.render(context, params);
		context.popTransform();
	}

	private static var _workTransform:ArpTransform = new ArpTransform();
	private static function transform(params:IArpParamsRead, paramsOp:ParamsOp):ArpTransform {
		var transform:ArpTransform = _workTransform;
		if (paramsOp != null) params = paramsOp.filter(params);
		transform.reset(
			params.getFloatOrDefault("a", 1),
			params.getFloatOrDefault("b", 0),
			params.getFloatOrDefault("c", 0),
			params.getFloatOrDefault("d", 1),
			params.getFloatOrDefault("x", 0),
			params.getFloatOrDefault("y", 0)
		);
		return transform;
	}
}

