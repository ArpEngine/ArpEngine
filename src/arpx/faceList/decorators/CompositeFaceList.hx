package arpx.faceList.decorators;

import arp.ds.IList;
import arp.iterators.CompositeIterator;

@:arpType("faceList", "composite")
class CompositeFaceList extends FaceList {

	@:arpField(true) @:arpBarrier public var faceLists:IList<FaceList>;
	public function new() super();

	override private function get_length():Int return Lambda.fold(faceLists, (i, m) -> i.length + m, 0);

	override public function indexOf(face:String):Int {
		var pos:Int = 0;
		for (faceList in faceLists) {
			var index:Int = faceList.indexOf(face);
			if (index >= 0) return index + pos;
			pos += faceList.length;
		}
		return -1;
	}

	override public function faceSpan(face:String):Null<FaceSpan> {
		for (faceList in faceLists) {
			var faceSpan:Null<FaceSpan> = faceList.faceSpan(face);
			if (faceSpan != null) return faceSpan;
		}
		return null;
	}

	override public function faceSpanAt(index:Int):Null<FaceSpan> {
		var pos:Int = 0;
		for (faceList in faceLists) {
			var len:Int = faceList.length;
			if (pos + len > index) return faceList.faceSpanAt(index - pos);
			pos += len;
		}
		return null;
	}

	override public function iterator():Iterator<FaceSpan> return new CompositeIterator(this.faceLists);
}
