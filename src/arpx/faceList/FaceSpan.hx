package arpx.faceList;

class FaceSpan {

	public var face:String;
	public var index:Int;
	public var dirs:Int;

	public function new(face:String, index:Int, dirs:Int) {
		this.face = face;
		this.index = index;
		this.dirs = dirs;
	}
}
