package arpx.impl.stub.geom;

#if (arp_display_backend_stub || arp_backend_display)

class MatrixImpl {

	public var raw(get, never):MatrixImpl;
	inline private function get_raw():MatrixImpl return this;

	public var xx:Float;
	public var yx:Float;
	public var xy:Float;
	public var yy:Float;
	public var tx:Float;
	public var ty:Float;

	public function new() return;
	inline public static function alloc():MatrixImpl return new MatrixImpl();

	inline public function identity():Void return;
	inline public function reset2d(a:Float = 1, b:Float = 0, c:Float = 0, d:Float = 1, tx:Float = 0, ty:Float = 0):Void return;
	inline public function clone():MatrixImpl return new MatrixImpl();
	inline public function copyFrom(matrix:MatrixImpl):Void return;

	inline public function invert():Void return;

	inline public function resetSkew():Void return;
	inline public function resetScale(scale:Float = 1):Void return;
	inline public function resetTranslation():Void return;

	inline public function prependMatrix(matrix:MatrixImpl):Void return;
	inline public function prependXY(x:Float, y:Float):Void return;
	inline public function appendMatrix(matrix:MatrixImpl):Void return;
	inline public function appendXY(x:Float, y:Float):Void return;
}


#end
