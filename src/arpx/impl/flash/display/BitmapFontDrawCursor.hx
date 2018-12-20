package arpx.impl.flash.display;

#if (flash || openfl)

import flash.geom.Rectangle;

class BitmapFontDrawCursor {

	private var bitmapFont:BitmapFont;
	private var width:Int = 0;
	private var height:Int = 0;

	private var lineHeight:Int = 0;
	public var x(default, null):Int = 0;
	public var y(default, null):Int = 0;
	private var nextX:Int = 0;

	private var padding:Int = 1;

	inline public function new(bitmapFont:BitmapFont, width:Int, height:Int) {
		this.bitmapFont = bitmapFont;
		this.width = width;
		this.height = height;
	}

	inline public function move(charCode:Int):Void {
		var bounds:Rectangle = this.bitmapFont.getBounds(charCode);
		if (this.nextX + bounds.width > this.width) {
			this.y += this.lineHeight + this.padding;
			this.lineHeight = 0;
			this.nextX = 0;
		}
		this.x = this.nextX;
		var h:Int = Math.ceil(bounds.height);
		if (this.lineHeight < h) this.lineHeight = h;
		this.nextX += Math.ceil(bounds.width) + this.padding;
	}
}

#end
