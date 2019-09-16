package arpx.structs;

import arpx.structs.params.ArpParamsValue;
import arp.domain.IArpStruct;
import arp.persistable.IPersistInput;
import arp.persistable.IPersistOutput;
import arp.seed.ArpSeed;
import arp.utils.ArpStringUtil;
import arpx.structs.ArpDirection;
import arpx.structs.params.EmptyArpParams;
import arpx.structs.params.ReadOnlyArpParams;

@:arpStruct("Params")
@:arpStructPlaceholder("params", { value: "params" })
class ArpParams extends ReadOnlyArpParams implements IArpStruct implements IArpParamsRead {

	public static var empty(default, null) = new EmptyArpParams();

	public function new() super();

	inline public function set(key:ArpParamsKey, value:ArpParamsValue):Void this.impl[key.index] = value;
	inline public function clear():Void this.impl = [];

	public function initWithSeed(seed:ArpSeed):ArpParams {
		if (seed == null) return this;
		return initWithString(seed.value);
	}

	public function initWithString(definition:String):ArpParams {
		if (definition == null) return this;
		for (node in definition.split(",")) {
			var array:Array<String> = node.split(":");
			if (array.length == 1) {
				this.set("face", array[0]);
				continue;
			}
			var key:String = array[0];
			var value:String = array[1];
			var type:String = array[2];
			switch (type) {
				case "dir":
					this.set(key, new ArpDirection().initWithString(value));
				case "idir":
					this.set(key, new ArpDirection(ArpStringUtil.parseHex(value)));
				default:
					if (ArpStringUtil.isNumeric(value)) {
						this.set(key, ArpStringUtil.parseFloatDefault(value));
					} else {
						this.set(key, value);
					}
			}
		}
		return this;
	}

	public function clone():ArpParams {
		var result:ArpParams = new ArpParams();
		result.copyFrom(this);
		return result;
	}

	public function copyFrom(source:IArpParamsRead = null):ArpParams {
		this.clear();
		if (source != null) {
			for (name in source.keys()) {
				this.set(name, source.get(name));
			}
		}
		return this;
	}

	public function merge(source:IArpParamsRead = null):ArpParams {
		if (source != null) {
			for (name in source.keys()) {
				this.set(name, source.get(name));
			}
		}
		return this;
	}

	public function readSelf(input:IPersistInput):Void {
		initWithString(input.readUtf("params"));
	}

	public function writeSelf(output:IPersistOutput):Void {
		output.writeUtf("params", toString());
	}
}
