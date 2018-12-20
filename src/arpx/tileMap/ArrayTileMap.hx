package arpx.tileMap;

@:arpType("tileMap", "array")
class ArrayTileMap extends TileMap {

	@:arpField public var outerTileIndex:Int;

	public function new() {
		super();
	}

	public static function fromArray(array:Array<Array<Int>>):ArrayTileMap {
		var arrayTileMap:ArrayTileMap = new ArrayTileMap();
		arrayTileMap.map = array;
		return arrayTileMap;
	}

	private var map:Array<Array<Int>>;

	@:arpHeatUp
	private function heatUp():Bool {
		if (this.map == null) this.map = [for (i in 0...this.height) []];
		return true;
	}

	@:arpHeatDown
	private function heatDown():Bool {
		this.map = null;
		return true;
	}

	override private function get_isInfinite():Bool {
		return this.outerTileIndex != 0;
	}

	override public function getTileIndexAtGrid(gridX:Int, gridY:Int):Int {
		if (this.map == null) this.heatUp();
		if (gridX < 0 || gridX >= this.width || gridY < 0 || gridY >= this.height) {
			return this.outerTileIndex;
		}
		return this.map[gridY][gridX];
	}

	override public function setTileIndexAtGrid(gridX:Int, gridY:Int, value:Int):Void {
		if (this.map == null) this.heatUp();
		if (gridY < 0 || gridX >= this.width || gridY < 0 || gridY >= this.height) {
			return;
		}
		this.map[gridY][gridX] = value;
	}
}


