package arpx.impl.stub.geom;

#if (arp_display_backend_stub || arp_backend_display)

class RectImpl {

	public var x:Float;
	public var y:Float;
	public var width:Float;
	public var height:Float;

	inline public function new(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0) {
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
	}

	inline public static function alloc(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0):RectImpl return new RectImpl(x, y, width, height);

	inline public function reset(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0):Void {
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
	}

	inline public function clone():RectImpl return new RectImpl(this.x, this.y, this.width, this.height);

	inline public function copyFrom(rect:RectImpl):Void {
		this.x = rect.x;
		this.y = rect.y;
		this.width = rect.width;
		this.height = rect.height;
	}

	inline public function translateXY(x:Float, y:Float):Void {
		this.x += x;
		this.y += y;
	}

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
