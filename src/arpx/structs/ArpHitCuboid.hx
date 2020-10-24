package arpx.structs;

import arp.utils.ArpSeedUtil;
import arp.utils.ArpStringUtil;
import arp.domain.IArpStruct;
import arp.persistable.IPersistInput;
import arp.persistable.IPersistOutput;
import arp.seed.ArpSeed;

/**
	* handled as immutable
	* @author kaikoga
*/
@:arpStruct("HitCuboid")
@:arpStructPlaceholder("dX,dY,dZ,sizeX,sizeY,sizeZ", { x: "dX", y: "dY", z: "dZ", width: "sizeX", height: "sizeY", depth: "sizeZ" })
class ArpHitCuboid implements IArpStruct {

	public var dX:Float = 0;
	public var dY:Float = 0;
	public var dZ:Float = 0;
	public var sizeX:Float = 0;
	public var sizeY:Float = 0;
	public var sizeZ:Float = 0;

	private var _gridSize:Float = 1;
	public var gridSize(get, set):Float;
	private function get_gridSize():Float return this._gridSize;
	private function set_gridSize(value:Float):Float return this._gridSize = value;

	public var gridScale(get, set):Float;
	private function get_gridScale():Float {
		return this._gridSize;
	}
	private function set_gridScale(value:Float):Float {
		var f:Float = value / this._gridSize;
		this.dX = this.dX * f;
		this.dY = this.dY * f;
		this.dZ = this.dZ * f;
		this.sizeX = this.sizeX * f;
		this.sizeY = this.sizeY * f;
		this.sizeZ = this.sizeZ * f;
		this._gridSize = value;
		return value;
	}

	public var areaLeft(get, never):Float;
	inline private function get_areaLeft():Float return this.dX - sizeX;
	public var areaRight(get, never):Float;
	inline private function get_areaRight():Float return this.dX + sizeX;
	public var areaTop(get, never):Float;
	inline private function get_areaTop():Float return this.dY - sizeY;
	public var areaBottom(get, never):Float;
	inline private function get_areaBottom():Float return this.dY + sizeY;
	public var areaHind(get, never):Float;
	inline private function get_areaHind():Float return this.dZ - sizeZ;
	public var areaFore(get, never):Float;
	inline private function get_areaFore():Float return this.dZ + sizeZ;

	public function new() {
	}

	public function initWithSeed(seed:ArpSeed):ArpHitCuboid {
		if (seed == null) return this;
		var value:String = seed.value;
		if (value != null) return this.initWithString(value, seed.env.getUnit);

		for (element in seed) {
			switch (element.seedName) {
				case "dX", "x":
					this.dX = ArpSeedUtil.parseFloatDefault(element);
				case "dY", "y":
					this.dY = ArpSeedUtil.parseFloatDefault(element);
				case "dZ", "z":
					this.dZ = ArpSeedUtil.parseFloatDefault(element);
				case "sizeX", "width":
					this.sizeX = ArpSeedUtil.parseFloatDefault(element);
				case "sizeY", "height":
					this.sizeY = ArpSeedUtil.parseFloatDefault(element);
				case "sizeZ", "depth":
					this.sizeZ = ArpSeedUtil.parseFloatDefault(element);
			}
		}
		return this;
	}

	public function initWithString(definition:String, getUnit:String->Float):ArpHitCuboid {
		if (definition == null) return this;
		var ereg:EReg = ~/^\s*(\S*)\s*,\s*(\S*)\s*,\s*(\S*)\s*,\s*(\S*)\s*,\s*(\S*)\s*,\s*(\S*)\s*$/;
		if (ereg.match(definition)) {
			this.dX = ArpStringUtil.parseRichFloat(ereg.matched(1), getUnit);
			this.dY = ArpStringUtil.parseRichFloat(ereg.matched(2), getUnit);
			this.dZ = ArpStringUtil.parseRichFloat(ereg.matched(3), getUnit);
			this.sizeX = ArpStringUtil.parseRichFloat(ereg.matched(4), getUnit);
			this.sizeY = ArpStringUtil.parseRichFloat(ereg.matched(5), getUnit);
			this.sizeZ = ArpStringUtil.parseRichFloat(ereg.matched(6), getUnit);
		}
		return this;
	}

	public function clone():ArpHitCuboid {
		var result:ArpHitCuboid = new ArpHitCuboid();
		result.copyFrom(this);
		return result;
	}

	public function copyFrom(source:ArpHitCuboid):ArpHitCuboid {
		this.dX = source.dX;
		this.dY = source.dY;
		this.dZ = source.dZ;
		this.sizeX = source.sizeX;
		this.sizeY = source.sizeY;
		this.sizeZ = source.sizeZ;
		return this;
	}

	public function toString():String {
		return '[ArpHitArea {$dX,$dY,$dZ}*{$sizeX,$sizeY,$sizeZ}]';
	}

	public function readSelf(input:IPersistInput):Void {
		this.dX = input.readDouble("dX");
		this.dY = input.readDouble("dY");
		this.dZ = input.readDouble("dZ");
		this.sizeX = input.readDouble("sizeX");
		this.sizeY = input.readDouble("sizeY");
		this.sizeZ = input.readDouble("sizeZ");
	}

	public function writeSelf(output:IPersistOutput):Void {
		output.writeDouble("dX", this.dX);
		output.writeDouble("dY", this.dY);
		output.writeDouble("dZ", this.dZ);
		output.writeDouble("sizeX", this.sizeX);
		output.writeDouble("sizeY", this.sizeY);
		output.writeDouble("sizeZ", this.sizeZ);
	}
}


