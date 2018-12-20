package arpx.chip.stringChip;

import arpx.structs.ArpParamsKey;
import arpx.impl.cross.geom.RectImpl;
import arpx.structs.ArpParams;
import arpx.structs.IArpParamsRead;

class StringChipFont {

	public var chip(default, null):Chip;
	public var params(default, null):IArpParamsRead;

	private var chipSize:Map<String, RectImpl>;
	public var charParams(default, null):ArpParams;

	public function getCharChipSize(char:String):RectImpl {
		if (this.chipSize.exists(char)) {
			return this.chipSize.get(char);
		} else {
			var rect:RectImpl = RectImpl.alloc();
			this.charParams.set("face", char);
			this.chip.layoutSize(this.charParams, rect);
			this.chipSize.set(char, rect);
			return rect;
		}
	}

	public function new(chip:Chip, params:IArpParamsRead) {
		this.chip = chip;
		this.chipSize = new Map<String, RectImpl>();
		this.charParams = new ArpParams().copyFrom(params);
		this.charParams.set("face", null);
		this.params = new ArpParams().copyFrom(this.charParams);
	}

	public function match(chip:Chip, params:IArpParamsRead):Bool {
		if (chip != this.chip) return false;
		for (key in params.keys()) {
			if (key == new ArpParamsKey(1)) continue;
			if (params.get(key) != this.params.get(key)) return false;
		}
		return true;
	}

	inline public static function cached(chip:Chip, params:IArpParamsRead):StringChipFont return StringChipFontCache.instance.get(chip, params);
}

