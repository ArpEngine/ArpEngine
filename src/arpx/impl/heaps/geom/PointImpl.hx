package arpx.impl.heaps.geom;

#if (arp_display_backend_heaps || arp_backend_display)

import h3d.col.Point;

@:forward(x, y)
abstract PointImpl(Point) from Point {

	public var raw(get, never):Point;
	inline private function get_raw():Point return this;

	inline public function new(raw:Point) this = raw;

	inline public static function alloc(x:Float = 0, y:Float = 0) return new PointImpl(new Point(x, y));

	inline public function reset(x:Float = 0, y:Float = 0, z:Float = 0):Void this.set(x, y, z);

	inline public function transform(matrix:MatrixImpl):Void this.transform(matrix.raw);
}

#end
