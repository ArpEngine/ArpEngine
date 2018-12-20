package arpx.impl.heaps.display;

#if (arp_display_backend_heaps || arp_backend_display)

import hxd.Charset;

class CharsetCjk extends Charset {
	override public function isCJK(code) {
		if (code >= 0x2E80 && code <= 0x9FFF) return true;
		if (code >= 0xAC00 && code <= 0xFAFF) return true;
		if (code >= 0x1F000) return true;
		return false;
	}

	@:isVar public static var instance(get, null):Charset;
	private static function get_instance():Charset return if (instance != null) instance else instance = new CharsetCjk();
}

#end
