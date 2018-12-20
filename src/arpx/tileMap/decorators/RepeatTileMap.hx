package arpx.tileMap.decorators;

@:arpType("tileMap", "repeat")
class RepeatTileMap extends TileMap {

	@:arpBarrier @:arpField public var tileMap:TileMap;
	@:arpField public var repeatX:Bool;
	@:arpField public var repeatY:Bool;

	public function new() {
		super();
	}

	private function sourceX(x:Int):Int {
		if (this.repeatX) {
			if (x < 0) {
				return (x % this.tileMap.width + this.tileMap.width) % this.tileMap.width;
			}
			return x % this.tileMap.width;
		}
		return x;
	}

	private function sourceY(y:Int):Int {
		if (this.repeatY) {
			if (y < 0) {
				return (y % this.tileMap.height + this.tileMap.height) % this.tileMap.height;
			}
			return y % this.tileMap.height;
		}
		return y;
	}

	override private function get_width():Int {
		return this.tileMap.width;
	}

	override private function get_height():Int {
		return this.tileMap.height;
	}

	override private function get_isInfinite():Bool {
		return true;
	}

	override public function getTileIndexAtGrid(gridX:Int, gridY:Int):Int {
		return this.tileMap.getTileIndexAtGrid(this.sourceX(gridX), this.sourceY(gridY));
	}

	override public function setTileIndexAtGrid(gridX:Int, gridY:Int, value:Int):Void {
		this.tileMap.setTileIndexAtGrid(this.sourceX(gridX), this.sourceY(gridY), value);
	}
}
