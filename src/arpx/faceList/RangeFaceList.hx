package arpx.faceList;

import arpx.structs.ArpRange;

@:arpType("faceList", "range")
class RangeFaceList extends ArrayFaceList {

	@:arpField public var isVertical:Bool;

	@:arpField public var range:ArpRange;

	public function new() super();

	override private function populate():Void {
		if (this.range.hasValue) for (face in this.range.split()) this.add(face, 1, this.isVertical);
	}
}
