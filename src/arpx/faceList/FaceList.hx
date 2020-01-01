package arpx.faceList;

import arp.domain.IArpObject;
import arp.iterators.EmptyIterator;

@:arpType("faceList", "null")
class FaceList implements IArpObject {

	public function new() return;

	public var length(get, never):Int;
	private function get_length():Int return 0;
	public function indexOf(face:String):Int return -1;
	public function get(index:Int):Null<FaceSpan> return null;
	public function iterator():Iterator<FaceSpan> return new EmptyIterator();
}
