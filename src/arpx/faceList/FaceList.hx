package arpx.faceList;

import arp.domain.IArpObject;

@:arpType("faceList", "null")
class FaceList implements IArpObject {

	private var arrayValue:Array<FaceSpan>;
	private var resolveIndex:Map<Int, FaceSpan>;
	private var resolveFace:Map<String, FaceSpan>;

	public var length(default, null):Int;


	public function new() return;

	@:arpHeatUp
	final private function heatUp():Bool {
		this.arrayValue = [];
		this.resolveFace = new Map();
		this.resolveIndex = new Map();
		this.length = 0;
		populate((face:String, size:Int) -> {
			// Don't use Omap because face may be not unique and is sparse index
			var faceSpan:FaceSpan = new FaceSpan(face, this.length, size);
			this.arrayValue.push(faceSpan);
			if (!this.resolveFace.exists(face)) this.resolveFace.set(face, faceSpan);
			this.resolveIndex.set(this.length, faceSpan);
			this.length += size;
		});
		return true;
	}

	private function populate(add:(face:String, size:Int)->Void):Void {
	}

	@:arpHeatDown
	private function heatDown():Bool {
		this.arrayValue = null;
		this.resolveFace = null;
		this.length = 0;
		return true;
	}

	public function indexOf(face:String):Int {
		if (this.arrayValue == null) this.heatUp();
		return if (this.resolveFace.exists(face)) this.resolveFace.get(face).index else -1;
	}

	public function faceSpan(face:String):Null<FaceSpan> {
		if (this.arrayValue == null) this.heatUp();
		return this.resolveFace.get(face);
	}

	public function faceSpanAt(index:Int):Null<FaceSpan> {
		if (this.arrayValue == null) this.heatUp();
		return this.resolveIndex.get(index);
	}

	public function iterator():Iterator<FaceSpan> {
		if (this.arrayValue == null) this.heatUp();
		return this.arrayValue.iterator();
	}
}
