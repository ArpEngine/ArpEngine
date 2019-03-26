package arpx.paramsOp.filters;

import arpx.structs.ArpParamsKey;
import arpx.structs.IArpParamsRead;
import arpx.structs.params.ArpParamsValue;

class RewireParamsOpFilter extends ArpParamsFilter {
	private var paramsOp:RewireParamsOp;

	public function new(paramsOp:RewireParamsOp, source:IArpParamsRead) {
		super(source);
		this.paramsOp = paramsOp;
	}

	override public function get(key:ArpParamsKey):ArpParamsValue {
		var value:ArpParamsValue;
		value = super.get(this.paramsOp.rewireParams.getAsString(key));
		if (value != null) return value;
		value = this.paramsOp.fixedParams.get(key);
		if (value != null) return value;
		if (this.paramsOp.copy) {
			value = super.get(key);
			if (value != null) return value;
		}
		return null;
	}
}
