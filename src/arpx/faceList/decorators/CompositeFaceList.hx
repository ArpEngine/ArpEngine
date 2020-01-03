package arpx.faceList.decorators;

import arp.ds.IList;

@:arpType("faceList", "composite")
class CompositeFaceList extends FaceList {

	@:arpField(true) @:arpBarrier public var faceLists:IList<FaceList>;
	public function new() super();

	override private function populate(add:(face:String, size:Int)->Void):Void {
		for (faceList in faceLists) {
			for (faceSpan in faceList) {
				add(faceSpan.face, faceSpan.dirs);
			}
		}
	}
}
