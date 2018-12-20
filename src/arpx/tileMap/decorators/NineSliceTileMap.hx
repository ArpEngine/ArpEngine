package arpx.tileMap.decorators;

@:arpType("tileMap", "nineSlice")
class NineSliceTileMap extends TileMap {

	@:arpBarrier @:arpField public var tileMap:TileMap;
	@:arpField public var bodyLeft:Int;
	@:arpField public var bodyRight:Int;
	@:arpField public var bodyTop:Int;
	@:arpField public var bodyBottom:Int;

	public function new() {
		super();
	}

	private function sourceX(x:Int):Int {
		if (x < this.bodyLeft) {
			return x;
		}
		else if (this.width - x <= this.tileMap.width - this.bodyRight) {
			return x - this.width + this.tileMap.width;
		}
		return this.bodyLeft + (x - this.bodyLeft) % (this.bodyRight - this.bodyLeft);
	}

	private function sourceY(y:Int):Int {
		if (y < this.bodyTop) {
			return y;
		}
		else if (this.height - y <= this.tileMap.height - this.bodyBottom) {
			return y - this.height + this.tileMap.height;
		}
		return this.bodyTop + (y - this.bodyTop) % (this.bodyBottom - this.bodyTop);
	}

	override private function get_isInfinite():Bool {
		return false;
	}

	override public function getTileIndexAtGrid(gridX:Int, gridY:Int):Int {
		return this.tileMap.getTileIndexAtGrid(this.sourceX(gridX), this.sourceY(gridY));
	}

	override public function setTileIndexAtGrid(gridX:Int, gridY:Int, value:Int):Void {
		this.tileMap.setTileIndexAtGrid(this.sourceX(gridX), this.sourceY(gridY), value);
	}
}
