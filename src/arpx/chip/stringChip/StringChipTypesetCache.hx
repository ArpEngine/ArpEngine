package arpx.chip.stringChip;

import arpx.structs.IArpParamsRead;

class StringChipTypesetCache {

	private var cache:Array<StringChipTypeset>;

	public function new() this.cache = [];

	public function get(chip:StringChip, params:IArpParamsRead):StringChipTypeset {
		if (this.cache.length >= 256) this.cache.splice(0, 64);
		for (typeset in this.cache) {
			if (typeset.match(chip, params)) {
				return typeset;
			}
		}
		var typeset:StringChipTypeset = new StringChipTypeset(chip, params);
		this.cache.push(typeset);
		return typeset;
	}

	private static var _instance:StringChipTypesetCache;
	public static var instance(get, never):StringChipTypesetCache;

	private static function get_instance():StringChipTypesetCache return if (_instance != null) _instance else _instance = new StringChipTypesetCache();
}
