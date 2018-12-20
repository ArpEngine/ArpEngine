package arpx.faceList;

import arp.domain.IArpObject;
import arp.iterators.EmptyIterator;

@:arpType("faceList", "null")
class FaceList implements IArpObject {

	public function new() return;

	public var isVertical(get, never):Bool;
	private function get_isVertical():Bool return false;
	public var length(get, never):Int;
	private function get_length():Int return 0;
	public function indexOf(name:String):Int return -1;
	public function get(index:Int):String return null;
	public function iterator():Iterator<String> return new EmptyIterator();
}
