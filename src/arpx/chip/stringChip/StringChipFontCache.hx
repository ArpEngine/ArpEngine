package arpx.chip.stringChip;

import arpx.structs.IArpParamsRead;

class StringChipFontCache {

	private var cache:Array<StringChipFont>;

	public function new() this.cache = [];

	public function get(chip:Chip, params:IArpParamsRead):StringChipFont {
		if (this.cache.length >= 64) this.cache.splice(0, 32);
		for (font in this.cache) {
			if (font.match(chip, params)) {
				return font;
			}
		}
		var font:StringChipFont = new StringChipFont(chip, params);
		this.cache.push(font);
		return font;
	}

	private static var _instance:StringChipFontCache;
	public static var instance(get, never):StringChipFontCache;

	private static function get_instance():StringChipFontCache return if (_instance != null) _instance else _instance = new StringChipFontCache();
}
