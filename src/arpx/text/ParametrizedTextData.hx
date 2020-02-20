package arpx.text;

import arp.utils.FormatText;
import arpx.structs.ArpParams;

@:arpType("text", "ptext")
class ParametrizedTextData extends TextData {

	@:arpField public var value:String = null;

	private var impl:FormatText;

	public function new() super();

	@:arpHeatUp private function heatUp():Bool {
		if (this.impl != null) return true;
		var value = if (this.value == null) "null" else this.value;
		var customFormatter = (param:Any) -> if (Std.is(param, TextData)) (param:TextData).publish() else null;
		this.impl = new FormatText(value, customFormatter);
		return true;
	}

	override public function publish(params:ArpParams = null):String {
		if (this.impl == null) this.heatUp();

		return if (params == null) this.value else this.impl.publish((name:String) -> params.get(name));
	}
}
