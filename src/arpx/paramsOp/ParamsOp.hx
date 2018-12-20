package arpx.paramsOp;

import arp.domain.IArpObject;
import arpx.structs.IArpParamsRead;

@:arpType("paramsOp", "null")

class ParamsOp implements IArpObject {

	public function new() {
	}

	public function filter(source:IArpParamsRead):IArpParamsRead return source;
}
