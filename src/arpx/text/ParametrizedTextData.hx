package arpx.text;

import arp.utils.FormatOption;
import arp.utils.FormatText;
import arpx.chip.utils.StringChipUtil;
import arpx.structs.ArpParams;

@:arpType("text", "ptext")
class ParametrizedTextData extends TextData {

	@:arpField public var value:String = null;

	private var _impl:FormatText;
	private var impl(get, null):FormatText;
	private function get_impl():FormatText {
		var value = if (this.value == null) "null" else this.value;
		if (this._impl != null && this._impl.source == value) return this._impl;
		this._impl = new FormatText(value, _customFormatter, _customAlign);
		return this._impl;
	}

	public function new() super();

	override public function publish(params:ArpParams = null):String {
		return if (params == null) this.value else this.impl.publish((name:String) -> params.get(name));
	}

	private function _customFormatter(param:Any, formatOption:FormatOption):String return customFormatter(param, formatOption);
	private function _customAlign(str:String, formatOption:FormatOption):String return customAlign(str, formatOption);

	dynamic public static function customFormatter(param:Any, formatOption:FormatOption):String {
		return defaultCustomFormatter(param, formatOption);
	}

	dynamic public static function customAlign(str:String, formatOption:FormatOption):String {
		return defaultCustomAlign(str, formatOption);
	}

	inline public static function defaultCustomFormatter(param:Any, formatOption:FormatOption):String {
		return if (Std.is(param, TextData)) (param:TextData).publish() else Std.string(param);
	}

	inline public static function defaultCustomAlign(str:String, formatOption:FormatOption):String {
		return formatOption.basicPad(str, " ", (formatOption.width - StringChipUtil.lengthForStringChip(str)));
	}
}
