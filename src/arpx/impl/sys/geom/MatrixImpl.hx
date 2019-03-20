package arpx.impl.sys.geom;

#if (arp_display_backend_sys || arp_backend_display)

class MatrixImpl {

	public var raw(get, never):MatrixImpl;
	inline private function get_raw():MatrixImpl return this;

	public var xx:Float;
	public var yx:Float;
	public var xy:Float;
	public var yy:Float;
	public var tx:Float;
	public var ty:Float;

	inline public function new(xx:Float = 1, yx:Float = 0, xy:Float = 0, yy:Float = 1, tx:Float = 0, ty:Float = 0) reset2d(xx, yx, xy, yy, tx, ty);
	inline public static function alloc():MatrixImpl return new MatrixImpl();

	inline public function identity():Void {
		yy = xx = 1;
		ty = tx = xy = yx = 0;
	}
	inline public function reset2d(a:Float = 1, b:Float = 0, c:Float = 0, d:Float = 1, tx:Float = 0, ty:Float = 0):Void {
		this.xx = a;
		this.yx = b;
		this.xy = c;
		this.yy = d;
		this.tx = tx;
		this.ty = ty;
	}
	inline public function clone():MatrixImpl return new MatrixImpl(xx, yx, xy, yy, tx, ty);
	inline public function copyFrom(matrix:MatrixImpl):Void reset2d(matrix.xx, matrix.yx, matrix.xy, matrix.yy, matrix.tx, matrix.ty);

	inline public function invert():Void {
		var a = this.xx, b = this.yx;
		var c = this.xy, d = this.yy;
		var x = this.tx, y = this.ty;
		var invDet = 1 / (a * d - b * c);
		this.xx = d * invDet;
		this.yx = -b * invDet;
		this.xy = -c * invDet;
		this.yx = a * invDet;
		this.tx = (-x * d + c * y) * invDet;
		this.ty = (x * b - a * y) * invDet;
	}

	inline public function resetSkew():Void xy = yx = 0;
	inline public function resetScale(scale:Float = 1):Void yy = xx = scale;
	inline public function resetTranslation():Void ty = tx = 0;

	inline private function mult(l:MatrixImpl, r:MatrixImpl):Void {
		var lxx:Float = l.xx;
		var lyx:Float = l.yx;
		var lxy:Float = l.xy;
		var lyy:Float = l.yy;
		var ltx:Float = l.tx;
		var lty:Float = l.ty;
		var rxx:Float = r.xx;
		var ryx:Float = r.yx;
		var rxy:Float = r.xy;
		var ryy:Float = r.yy;
		var rtx:Float = r.tx;
		var rty:Float = r.ty;
		this.xx = lxx * rxx + lyx * rxy;
		this.yx = lxx * ryx + lyx * ryy;
		this.xy = lyx * rxx + lyy * rxy;
		this.yy = lyx * ryx + lyy * ryy;
		this.tx = lxx * rtx + lyx * rty + ltx;
		this.ty = lyx * rtx + lyy * rty + lty;
	}

	inline public function prependMatrix(matrix:MatrixImpl):Void {
		mult(this, matrix);
	}

	inline public function prependXY(x:Float, y:Float):Void {
		tx += x * xx + y * yx;
		ty += x * xy + y * yy;
	}

	inline public function appendMatrix(matrix:MatrixImpl):Void {
		mult(matrix, this);
	}

	inline public function appendXY(x:Float, y:Float):Void {
		tx += x;
		ty += y;
	}
}

#end
