package arpx.structs;

import arp.domain.IArpStruct;
import arp.persistable.IPersistOutput;
import arp.persistable.IPersistInput;
import arp.seed.ArpSeed;
import arp.utils.ArpStringUtil;

import arpx.structs.macro.ArpColorMacros.clamped;

#if flash
import flash.geom.ColorTransform;
#elseif openfl
import openfl.geom.ColorTransform;
#end

/**
	handled as mutable
*/
@:arpStruct("Color")
@:arpStructPlaceholder("#ffffff@ff", { value: "#ffffff@ff" })
class ArpColor implements IArpStruct {

	public var value32:Int;

	public var value(get, set):Int;
	inline private function get_value():Int return this.value32 & 0xffffff;
	inline private function set_value(value:Int):Int {
		this.value32 = (value & 0x00ffffff) | (this.value32 & 0xff000000);
		return value;
	}

	public var red(get, set):Int;
	inline private function get_red():Int return ((this.value32 >> 16) & 0xff);
	inline private function set_red(value:Int):Int {
		this.value32 = (clamped(value) << 16) | (this.value32 & 0xff00ffff);
		return value;
	}

	public var green(get, set):Int;
	inline private function get_green():Int return ((this.value32 >> 8) & 0xff);
	inline private function set_green(value:Int):Int {
		this.value32 = (clamped(value) << 8) | (this.value32 & 0xffff00ff);
		return value;
	}

	public var blue(get, set):Int;
	inline private function get_blue():Int return ((this.value32 >> 0) & 0xff);
	inline private function set_blue(value:Int):Int {
		this.value32 = (clamped(value) << 0) | (this.value32 & 0xffffff00);
		return value;
	}

	public var alpha(get, set):Int;
	private function get_alpha():Int return ((this.value32 >> 24) & 0xff);
	private function set_alpha(value:Int):Int {
		this.value32 = (clamped(value) << 24) | (this.value32 & 0x00ffffff);
		return value;
	}

	public var fred(get, set):Float;
	inline private function get_fred():Float return this.red / 0xff;
	inline private function set_fred(value:Float):Float {
		this.red = Math.round(value * 0xff);
		return value;
	}

	public var fgreen(get, set):Float;
	inline private function get_fgreen():Float return this.green / 0xff;
	inline private function set_fgreen(value:Float):Float {
		this.green = Math.round(value * 0xff);
		return value;
	}

	public var fblue(get, set):Float;
	inline private function get_fblue():Float return this.blue / 0xff;
	inline private function set_fblue(value:Float):Float {
		this.blue = Math.round(value * 0xff);
		return value;
	}

	public var falpha(get, set):Float;
	private function get_falpha():Float return this.alpha / 0xff;
	private function set_falpha(value:Float):Float {
		this.alpha = Math.round(value * 0xff);
		return value;
	}

	public function new(value:Int = 0xff000000) {
		this.value32 = value;
	}

	public function initWithSeed(seed:ArpSeed):ArpColor {
		if (seed == null) return this;
		return initWithString(seed.value);
	}

	public function initWithString(definition:String):ArpColor {
		if (definition == null) return this;
		var array:Array<String> = definition.split("@");
		var value:Int = ArpStringUtil.parseHex(array[0].substring(1));
		var alpha:Int = (array[1] != null) ? ArpStringUtil.parseHex(array[1]) : 0xff;
		this.value32 = (clamped(alpha) << 24) | value;
		return this;
	}

	public function clone():ArpColor {
		return new ArpColor(this.value32);
	}

	public function copyFrom(source:ArpColor = null):ArpColor {
		this.value32 = source.value32;
		return this;
	}

	public function toString():String {
		return "[ArpColor #" + Std.string(this.value32) + " ]";
	}

	#if (flash || openfl)

	public function toMultiplier():ColorTransform {
		return new ColorTransform(this.fred, this.fgreen, this.fblue, this.falpha);
	}

	public function toOffset():ColorTransform {
		return new ColorTransform(0, 0, 0, 0, this.red, this.green, this.blue, this.alpha);
	}

	public function toColorize():ColorTransform {
		var a:Float = this.falpha;
		var b:Float = 1 - a;
		return new ColorTransform(b, b, b, 1, this.red * a, this.green * a, this.blue * a, 0);
	}

	#end

	public function readSelf(input:IPersistInput):Void {
		this.value32 = input.readUInt32("color");
	}

	public function writeSelf(output:IPersistOutput):Void {
		output.writeUInt32("color", this.value32);
	}
}


