package arpx.faceList;

@:arpType("faceList", "array")
class ArrayFaceList extends FaceList {

	@:arpField public var isVertical:Bool;
	@:arpField public var unique:Bool;

	private var arrayValue:Array<String>;

	private function add(value:String):Void if (!unique || this.arrayValue.indexOf(value) == -1) this.arrayValue.push(value);

	public function new() super();

	@:arpHeatUp
	private function heatUp():Bool {
		this.arrayValue = [];
		return true;
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
		return this.arrayValue.indexOf(name);
	}

	override public function get(index:Int):String {
		if (this.arrayValue == null) this.heatUp();
		return this.arrayValue[index];
	}

	override public function iterator():Iterator<String> {
		if (this.arrayValue == null) this.heatUp();
		return this.arrayValue.iterator();
	}
}
