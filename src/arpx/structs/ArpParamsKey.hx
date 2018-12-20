package arpx.structs;

import arp.iterators.SimpleArrayIterator;

abstract ArpParamsKey(Int) {
	private static var keyMap:Map<String, Int> = new Map<String, Int>();
	private static var keyIndexes:Array<String> = [null];

	private static var _keys:Array<ArpParamsKey> = [];
	inline public static function keys():Iterator<ArpParamsKey> return new SimpleArrayIterator(_keys);

	private static function defineKey(value:String):Int {
		var keyIndex:Int = keyIndexes.length;
		keyMap.set(value, keyIndex);
		keyIndexes.push(value);
		_keys.push(new ArpParamsKey(keyIndex));
		return keyIndex;
	}

	public var index(get, never):Int;
	inline private function get_index():Int return this;

	inline public function new(index:Int) this = index;

	@:from
	inline public static function fromString(value:String):ArpParamsKey {
		return new ArpParamsKey(if (keyMap.exists(value)) keyMap.get(value) else defineKey(value));
	}

	@:to
	inline public function toString():String return keyIndexes[this];
}
