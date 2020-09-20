package arpx.text;

import arp.utils.FormatText;
import arpx.structs.ArpParams;

abstract ArpFormatParams(TFormatParams) to TFormatParams {

	inline private static function identity():ArpFormatParams {
		return (name:String) -> name;
	}

	@:from inline public static function fromArpParams(params:ArpParams = null):ArpFormatParams {
		return if (params == null) identity() else (name:String) -> params.get(name);
	}

	@:from inline public static function fromFunc(func:(name:String)->Any = null):ArpFormatParams {
		return if (func == null) identity() else cast func;
	}

	@:from inline public static function fromArray<T>(array:Array<T> = null):ArpFormatParams {
		return if (array == null) identity() else (name:String) -> array[Std.parseInt(name)];
	}

	inline public static function fromAnon(anon:Dynamic = null):ArpFormatParams {
		return if (anon == null) identity() else (name:String) -> Reflect.field(anon, name);
	}
}
