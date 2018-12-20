package arpx.impl.sys.geom;

#if (arp_display_backend_sys || arp_backend_display)

class PointImpl {

	public var raw(get, never):PointImpl;
	inline private function get_raw():PointImpl return this;

	public var x:Float;
	public var y:Float;

	public function new() return;

	inline public static function alloc(x:Float = 0, y:Float = 0) return new PointImpl();

	inline public function reset(x:Float = 0, y:Float = 0):Void return;

	inline public function transform(matrix:MatrixImpl):Void return;
}

#end
