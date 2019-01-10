package arpx.impl.flash.texture;

#if (arp_display_backend_flash || arp_backend_display)

import flash.geom.Rectangle;
import flash.display.BitmapData;
import flash.geom.Point;
import arpx.impl.cross.geom.RectImpl;
import arpx.impl.cross.texture.TextureFaceData;

class TextureFaceDataImpl {

	public var width(get, null):Int;
	inline private function get_width():Int return Std.int(bound.width);
	public var height(get, null):Int;
	inline private function get_height():Int return Std.int(bound.height);
	public var layoutSize(default, null):RectImpl;

	public var source(default, null):BitmapData;
	public var bound(default, null):Rectangle;

	private var _trimmed:BitmapData;
	public var trimmed(get, never):BitmapData;
	private function get_trimmed():BitmapData {
		if (this._trimmed != null) return this._trimmed;

		var result = new BitmapData(Std.int(bound.width), Std.int(bound.height), true, 0x00000000);
		result.copyPixels(source, bound, nullPoint);
		return this._trimmed = result;
	}

	private static var nullPoint:Point = new Point(0, 0);

	public function new(source:BitmapData, bound:Rectangle = null, layoutSize:RectImpl = null) {
		this.source = source;
		if (bound != null) {
			this.bound = bound;
		} else {
			this._trimmed = source;
			this.bound = source.rect;
		}
		this.layoutSize = if (layoutSize == null) this.bound else layoutSize;
	}

	inline public function trim(x:Float, y:Float, w:Float, h:Float, layoutSize:RectImpl = null):TextureFaceData {
		var bound:Rectangle = new Rectangle(x, y, w, h);
		return new TextureFaceDataImpl(this.source, bound, layoutSize);
	}

	public function dispose():Void if (this._trimmed != null) this._trimmed.dispose();
}

#end
