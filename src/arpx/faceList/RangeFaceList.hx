package arpx.faceList;

import arpx.structs.ArpRange;

@:arpType("faceList", "range")
class RangeFaceList extends FaceList {

	@:arpField public var dirs:Int = 1;

	@:arpField public var range:ArpRange;

	public function new() super();

	override private function populate(add:(face:String, size:Int)->Void):Void {
		if (this.range.hasValue) for (face in this.range.split()) add(face, this.dirs);
	}
}
