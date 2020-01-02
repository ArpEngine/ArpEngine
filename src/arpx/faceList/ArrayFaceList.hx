package arpx.faceList;

@:arpType("faceList", "array")
class ArrayFaceList extends FaceList {

	private var arrayValue:Array<FaceSpan>;
	private var resolveIndex:Map<Int, FaceSpan>;
	private var resolveFace:Map<String, Int>;

	private var _length:Int;
	override private function get_length():Int return _length;

	private function add(face:String, size:Int):Void {
		// Don't use Omap because face may be not unique and is sparse index
		var faceSpan:FaceSpan = new FaceSpan(face, size);
		if (!this.resolveFace.exists(face)) this.resolveFace.set(face, this._length);
		this.arrayValue.push(faceSpan);
		this.resolveIndex.set(this._length, faceSpan);
		this._length += size;
	}

	public function new() super();

	@:arpHeatUp
	final private function heatUp():Bool {
		this.arrayValue = [];
		this.resolveFace = new Map();
		this.resolveIndex = new Map();
		this._length = 0;
		populate();
		return true;
	}

	private function populate():Void {
	}

	@:arpHeatDown
	private function heatDown():Bool {
		this.arrayValue = null;
		this.resolveFace = null;
		this._length = 0;
		return true;
	}

	override public function indexOf(face:String):Int {
		if (this.arrayValue == null) this.heatUp();
		return if (this.resolveFace.exists(face)) this.resolveFace.get(face) else -1;
	}

	override public function faceSpan(face:String):Null<FaceSpan> {
		if (this.arrayValue == null) this.heatUp();
		return this.resolveIndex.get(this.resolveFace.get(face));
	}

	override public function faceSpanAt(index:Int):Null<FaceSpan> {
		if (this.arrayValue == null) this.heatUp();
		return this.resolveIndex.get(index);
	}

	override public function iterator():Iterator<FaceSpan> {
		if (this.arrayValue == null) this.heatUp();
		return this.arrayValue.iterator();
	}
}
