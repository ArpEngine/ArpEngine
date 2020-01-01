package arpx.faceList;

@:arpType("faceList", "array")
class ArrayFaceList extends FaceList {

	private var arrayValue:Array<FaceSpan>;
	private var resolveFace:Map<String, Int>;

	private function add(face:String, length:Int, isVertical:Bool):Void {
		// Don't use Omap because face may be not unique
		var faceSpan:FaceSpan = new FaceSpan(face, length, isVertical);
		if (!this.resolveFace.exists(face)) this.resolveFace.set(face, this.arrayValue.length);
		this.arrayValue.push(faceSpan);
	}

	public function new() super();

	@:arpHeatUp
	final private function heatUp():Bool {
		this.arrayValue = [];
		this.resolveFace = new Map();
		populate();
		return true;
	}

	private function populate():Void {
	}

	@:arpHeatDown
	private function heatDown():Bool {
		this.arrayValue = null;
		this.resolveFace = null;
		return true;
	}

	override private function get_length():Int {
		if (this.arrayValue == null) this.heatUp();
		return this.arrayValue.length;
	}

	override public function indexOf(name:String):Int {
		if (this.arrayValue == null) this.heatUp();
		return if (this.resolveFace.exists(name)) this.resolveFace.get(name) else -1;
	}

	override public function get(index:Int):Null<FaceSpan> {
		if (this.arrayValue == null) this.heatUp();
		return this.arrayValue[index];
	}

	override public function iterator():Iterator<FaceSpan> {
		if (this.arrayValue == null) this.heatUp();
		return this.arrayValue.iterator();
	}
}
