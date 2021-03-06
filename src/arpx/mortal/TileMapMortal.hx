package arpx.mortal;

import arp.hit.structs.HitGeneric;
import arpx.chip.Chip;
import arpx.impl.cross.mortal.TileMapMortalImpl;
import arpx.tileMap.TileMap;

@:arpType("mortal", "tileMap")
class TileMapMortal extends Mortal {

	@:arpBarrier @:arpField public var chip:Chip;
	@:arpBarrier @:arpField public var tileMap:TileMap;

	@:arpImpl private var arpImpl:TileMapMortalImpl;

	public function new() super();

	override private function get_isComplex():Bool return true;

	override public function complexHitTest(self:HitGeneric, other:HitGeneric):Bool {
		var gridX:Int = Math.floor((other.x - self.x) / tileMap.tileInfo.tileWidth);
		var gridY:Int = Math.floor((other.y - self.y) / tileMap.tileInfo.tileHeight);
		var tile:Int = tileMap.getTileIndexAtGrid(gridX, gridY);
		var z:Float = self.z + tileMap.tileInfo.tileZ(tile);
		return other.z < z;
	}
}


