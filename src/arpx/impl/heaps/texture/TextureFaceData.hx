package arpx.impl.heaps.texture;

#if (arp_display_backend_heaps || arp_backend_display)

import h2d.Tile;

import arpx.impl.cross.geom.RectImpl;

class TextureFaceData {

	public var tile(default, null):Tile;

	public var width(get, never):Int;
	private function get_width():Int return this.tile.width;
	public var height(get, never):Int;
	private function get_height():Int return this.tile.height;

	public var layoutSize(default, null):RectImpl;

	inline public function new(tile:Tile, layoutSize:RectImpl = null) {
		this.tile = tile;
		if (layoutSize == null) {
			this.layoutSize = RectImpl.alloc(0, 0, tile.width, tile.height);
		} else {
			this.layoutSize = layoutSize;
		}
	}

	inline public function trim(x:Float, y:Float, w:Float, h:Float, layoutSize:RectImpl = null):TextureFaceData {
		return new TextureFaceData(this.tile.sub(Std.int(x), Std.int(y), Std.int(w), Std.int(h)), layoutSize);
	}

	inline public function dispose():Void this.tile.dispose();
}

#end
