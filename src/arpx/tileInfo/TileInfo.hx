package arpx.tileInfo;

import arp.domain.IArpObject;
import arpx.structs.ArpRange;

@:arpType("tileInfo")
class TileInfo implements IArpObject {

	@:arpField public var tileWidth:Float = 32;
	@:arpField public var tileHeight:Float = 32;

	@:arpField public var enterableRange:ArpRange;

	public function new() {
	}

	public function tileZ(tileIndex:Int):Float {
		if (tileIndex == 0) {
			return 0;
		}
		if (this.enterableRange.contains(tileIndex)) {
			return 0;
		}
		return 1;
	}
}
