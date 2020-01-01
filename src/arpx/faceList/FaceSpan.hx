package arpx.faceList;

import arp.domain.IArpObject;

class FaceSpan {

	public var face:String;
	public var length:Int;
	public var isVertical:Bool;

	public function new(face:String, length:Int, isVertical:Bool) {
		this.face = face;
		this.length = length;
		this.isVertical = isVertical;
	}
}
