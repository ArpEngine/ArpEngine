package arpx.tileMap;

@:arpType("tileMap", "null")
class InfiniteTileMap extends TileMap {

	@:arpField public var tileIndex:Int;
	@:arpField public var outerTileIndex:Int;

	public function new() {
		super();
	}

	override private function get_isInfinite():Bool {
		return this.outerTileIndex != 0;
	}

	override public function getTileIndexAtGrid(gridX:Int, gridY:Int):Int {
		var isInner:Bool = gridX >= 0 && gridX < this.width && gridY >= 0 && gridY < this.height;
		return (isInner) ? this.tileIndex : this.outerTileIndex;
	}

	override public function setTileIndexAtGrid(gridX:Int, gridY:Int, value:Int):Void {

	}
}


