package arpx.paramsOp.decorators;

import arp.ds.IOmap;
import arpx.structs.IArpParamsRead;

@:arpType("paramsOp", "select")
class SelectParamsOp extends ParamsOp {

	@:arpField(true) public var paramsOps:IOmap<String, ParamsOp>;
	@:arpField public var selector:String;
	@:arpField public var defaultKey:String = "0";

	public function new() super();

	override public function filter(source:IArpParamsRead):IArpParamsRead {
		var paramsOp:ParamsOp = this.paramsOps.get(source.getAsString(this.selector, this.defaultKey));
		if (paramsOp != null) return paramsOp.filter(source);
		return source;
	}
}
