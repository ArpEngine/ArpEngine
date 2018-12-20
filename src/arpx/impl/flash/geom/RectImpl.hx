package arpx.impl.flash.geom;

#if (arp_display_backend_flash || arp_backend_display)

import flash.geom.Rectangle;

@:forward(x, y, width, height)
abstract RectImpl(Rectangle) from Rectangle {

	public var raw(get, never):Rectangle;
	inline private function get_raw():Rectangle return this;

	inline public function new(raw:Rectangle) this = raw;

	inline public static function alloc(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0):RectImpl return new RectImpl(new Rectangle(x, y, width, height));

	inline public function reset(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0):Void this.setTo(x, y, width, height);

	inline public function clone():RectImpl return this.clone();

	inline public function copyFrom(rect:RectImpl):Void this.copyFrom(rect.raw);

	inline public function translateXY(x:Float, y:Float):Void this.offset(x, y);

	inline public function transform(matrix:MatrixImpl):Void {
		reset(
			this.x * matrix.xx + this.y * matrix.yx + matrix.tx,
			this.x * matrix.xy + this.y * matrix.yy + matrix.ty,
			this.width * matrix.xx + this.height * matrix.yx,
			this.width * matrix.xy + this.height * matrix.yy
		);
	}
}

#end
