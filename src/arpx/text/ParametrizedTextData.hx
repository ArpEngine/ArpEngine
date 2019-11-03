package arpx.text;

import arp.utils.FormatText;
import arpx.structs.ArpParams;

@:arpType("text", "ptext")
class ParametrizedTextData extends TextData {

	@:arpField public var value:String = null;

	private var impl:FormatText;

	public function new() super();

	@:arpHeatUp private function heatUp():Bool {
		if (this.value == null) return true;
		if (this.impl != null) return true;
		this.impl = new FormatText(this.value);
		return true;
	}

	override public function publish(params:ArpParams = null):String {
		if (this.impl == null) this.heatUp();

		return if (params == null) {
			this.value;
		} else {
			this.impl.publish(key -> {
				var value:Dynamic = params.get(key);
				return if (Std.is(value, TextData)) {
					cast(value, TextData).publish();
				} else {
					Std.string(value);
				}
			});
		}
	}
}
