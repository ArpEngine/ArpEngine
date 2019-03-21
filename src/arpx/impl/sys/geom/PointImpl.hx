package arpx.impl.sys.geom;

#if (arp_display_backend_sys || arp_backend_display)

class PointImpl {

	public var raw(get, never):PointImpl;
	inline private function get_raw():PointImpl return this;

	public var x:Float;
	public var y:Float;

	inline public function new(x:Float = 0, y:Float = 0) this.reset(x, y);

	inline public static function alloc(x:Float = 0, y:Float = 0) return new PointImpl(x, y);

	inline public function reset(x:Float = 0, y:Float = 0):Void {
		this.x = x;
		this.y = y;
	}

	inline public function transform(matrix:MatrixImpl):Void {
		reset(
			this.x * matrix.xx + this.y * matrix.yx + matrix.tx,
			this.x * matrix.xy + this.y * matrix.yy + matrix.ty
		);
	}
}

#end
