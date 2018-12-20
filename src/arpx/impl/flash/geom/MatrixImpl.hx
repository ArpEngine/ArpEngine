package arpx.impl.flash.geom;

#if (arp_display_backend_flash || arp_backend_display)

import flash.geom.Matrix;

@:forward(tx, ty)
abstract MatrixImpl(Matrix) from Matrix {

	public var raw(get, never):Matrix;
	inline private function get_raw():Matrix return this;

	public var xx(get, set):Float;
	inline private function get_xx():Float return this.a;
	inline private function set_xx(value:Float):Float return this.a = value;

	public var yx(get, set):Float;
	inline private function get_yx():Float return this.b;
	inline private function set_yx(value:Float):Float return this.b = value;

	public var xy(get, set):Float;
	inline private function get_xy():Float return this.c;
	inline private function set_xy(value:Float):Float return this.c = value;

	public var yy(get, set):Float;
	inline private function get_yy():Float return this.d;
	inline private function set_yy(value:Float):Float return this.d = value;

	public var tx(get, set):Float;
	inline private function get_tx():Float return this.tx;
	inline private function set_tx(value:Float):Float return this.tx = value;

	public var ty(get, set):Float;
	inline private function get_ty():Float return this.ty;
	inline private function set_ty(value:Float):Float return this.ty = value;

	inline public function new(raw:Matrix) this = raw;

	inline public static function alloc():MatrixImpl return new MatrixImpl(new Matrix());

	inline public function identity():Void return;

	inline public function reset2d(a:Float = 1, b:Float = 0, c:Float = 0, d:Float = 1, tx:Float = 0, ty:Float = 0):Void {
		this.setTo(a, b, c, d, tx, ty);
	}

	inline public function clone():MatrixImpl {
		return this.clone();
	}

	inline public function copyFrom(matrix:MatrixImpl):Void {
		this.copyFrom(matrix.raw);
	}

	inline public function invert():Void {
		this.invert();
	}

	inline public function resetSkew():Void {
		xy = 0;
		yx = 0;
	}

	inline public function resetScale(scale:Float = 1):Void {
		xx = scale;
		yy = scale;
	}

	inline public function resetTranslation():Void {
		tx = 0;
		ty = 0;
	}

	inline public function prependMatrix(matrix:MatrixImpl):Void {
		var result:Matrix = matrix.raw.clone();
		result.concat(raw);
		this = result;
	}

	inline public function prependXY(x:Float, y:Float):Void {
		this.translate(x * xx + y * yx, x * xy + y * yy);
	}

	inline public function appendMatrix(matrix:MatrixImpl):Void {
		this.concat(matrix.raw);
	}

	inline public function appendXY(x:Float, y:Float):Void {
		this.translate(x, y);
	}
}

#end
