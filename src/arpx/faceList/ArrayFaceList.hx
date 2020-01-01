package arpx.faceList;

@:arpType("faceList", "array")
class ArrayFaceList extends FaceList {

	private var arrayValue:Array<FaceSpan>;

	private function add(face:String, length:Int, isVertical:Bool):Void {
		this.arrayValue.push(new FaceSpan(face, length, isVertical));
	}

	public function new() super();

	@:arpHeatUp
	final private function heatUp():Bool {
		this.arrayValue = [];
		populate();
		return true;
	}

	private function populate():Void {
	}

	@:arpHeatDown
	private function heatDown():Bool {
		this.arrayValue = null;
		return true;
	}

	override private function get_length():Int {
		if (this.arrayValue == null) this.heatUp();
		return this.arrayValue.length;
	}

	override public function indexOf(name:String):Int {
		if (this.arrayValue == null) this.heatUp();
		return findi(this.arrayValue, (n:FaceSpan) -> n.face == name);
	}

	override public function get(index:Int):Null<FaceSpan> {
		if (this.arrayValue == null) this.heatUp();
		return this.arrayValue[index];
	}

	override public function iterator():Iterator<FaceSpan> {
		if (this.arrayValue == null) this.heatUp();
		return this.arrayValue.iterator();
	}

	private static function findi<T>(it:Iterable<T>, f:(item:T) -> Bool):Int {
		var i = 0;
		for (v in it) {
			if (f(v))
				return i;
			i++;
		}
		return -1;
	}
}
