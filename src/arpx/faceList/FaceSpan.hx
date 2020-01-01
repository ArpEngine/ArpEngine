package arpx.faceList;

class FaceSpan {

	public var face:String;
	public var size:Int;
	public var isVertical:Bool;

	public function new(face:String, size:Int, isVertical:Bool) {
		this.face = face;
		this.size = size;
		this.isVertical = isVertical;
	}
}
