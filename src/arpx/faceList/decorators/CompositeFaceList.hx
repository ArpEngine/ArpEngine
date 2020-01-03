package arpx.faceList.decorators;

import arp.ds.IList;

@:arpType("faceList", "composite")
class CompositeFaceList extends ArrayFaceList {

	@:arpField(true) @:arpBarrier public var faceLists:IList<FaceList>;
	public function new() super();

	override private function populate():Void {
		for (faceList in faceLists) {
			for (faceSpan in faceList) {
				this.add(faceSpan.face, faceSpan.dirs);
			}
		}
	}
}
