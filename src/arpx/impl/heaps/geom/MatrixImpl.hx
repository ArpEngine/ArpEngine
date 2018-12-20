package arpx.impl.heaps.geom;

#if (arp_display_backend_heaps || arp_backend_display)

import arpx.impl.cross.structs.ArpTransform;
import h3d.Matrix;

@:forward(identity)
abstract MatrixImpl(Matrix) from Matrix {

	public var raw(get, never):Matrix;
	inline private function get_raw():Matrix return this;

	public var xx(get, set):Float;
	inline private function get_xx():Float return this._11;
	inline private function set_xx(value:Float):Float return this._11 = value;

	public var yx(get, set):Float;
	inline private function get_yx():Float return this._21;
	inline private function set_yx(value:Float):Float return this._21 = value;

	public var xy(get, set):Float;
	inline private function get_xy():Float return this._12;
	inline private function set_xy(value:Float):Float return this._12 = value;

	public var yy(get, set):Float;
	inline private function get_yy():Float return this._22;
	inline private function set_yy(value:Float):Float return this._22 = value;

	public var tx(get, set):Float;
	inline private function get_tx():Float return this._41;
	inline private function set_tx(value:Float):Float return this._41 = value;

	public var ty(get, set):Float;
	inline private function get_ty():Float return this._42;
	inline private function set_ty(value:Float):Float return this._42 = value;

	inline public function new(raw:Matrix) this = raw;

	inline public static function alloc():MatrixImpl return new MatrixImpl(new Matrix());

	inline public function reset2d(a:Float, b:Float, c:Float, d:Float, tx:Float, ty:Float):Void {
		this._11 = a;
		this._12 = c;
		this._13 = 0;
		this._14 = 0;
		this._21 = b;
		this._22 = d;
		this._23 = 0;
		this._24 = 0;
		this._31 = 0;
		this._32 = 0;
		this._33 = 1;
		this._34 = 0;
		this._41 = tx;
		this._42 = ty;
		this._43 = 0;
		this._44 = 1;
	}

	inline public function copyFrom(matrix:MatrixImpl):Void {
		this.load(matrix.raw);
	}

	inline public function invert():Void {
		this.invert();
	}

	public function resetSkew():Void {
		this._12 = 0;
		this._13 = 0;
		this._14 = 0;
		this._21 = 0;
		this._23 = 0;
		this._24 = 0;
		this._31 = 0;
		this._32 = 0;
		this._34 = 0;
	}

	public function resetScale(scale:Float = 1):Void {
		this._11 = scale;
		this._22 = scale;
		this._33 = scale;
		this._44 = 1;
	}

	public function resetTranslation():Void {
		this._41 = 0;
		this._42 = 0;
		this._43 = 0;
	}

	inline public function prependMatrix(transform:MatrixImpl):Void {
		this.multiply(transform.raw, this);
	}

	inline public function prependXY(x:Float, y:Float):Void {
		tx += x * xx + y * yx;
		ty += x * xy + y * yy;
	}

	inline public function appendMatrix(transform:MatrixImpl):Void {
		this.multiply(this, transform.raw);
	}

	inline public function appendXY(x:Float, y:Float):Void {
		tx += x;
		ty += y;
	}
}

#end
