package arpx.impl.flash.geom;

#if (arp_display_backend_flash || arp_backend_display)

import flash.geom.Point;

@:forward(x, y)
abstract PointImpl(Point) from Point {

	public var raw(get, never):Point;
	inline private function get_raw():Point return this;

	inline public function new(raw:Point) this = raw;

	inline public static function alloc(x:Float = 0, y:Float = 0):PointImpl return new PointImpl(new Point(x, y));

	inline public function reset(x:Float = 0, y:Float = 0):Void this.setTo(x, y);

	inline public function transform(matrix:MatrixImpl):Void this.copyFrom(matrix.raw.transformPoint(this));
}

#end
