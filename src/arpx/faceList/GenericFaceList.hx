package arpx.faceList;

import arp.iterators.ERegIterator;
import arpx.structs.ArpRange;

@:arpType("faceList", "faceList")
class GenericFaceList extends FaceList {

	@:arpField public var dirs:Int = 1;

	@:arpField public var extraFaces:Array<String>;
	@:arpField public var chars:String;
	@:arpField public var range:ArpRange;
	@:arpField("value") public var csvFaces:String;

	public function new() super();

	override private function populate(add:(face:String, size:Int)->Void):Void {
		if (this.chars != null) for (face in new ERegIterator(~/[^\n\r\t\/ ]|\/[^\/]*\//, this.chars)) add(face, this.dirs);
		if (this.range.hasValue) for (face in this.range.split()) add(face, this.dirs);
		if (this.csvFaces != null) for (face in ~/\s/g.replace(this.csvFaces, "").split(",")) add(face, this.dirs);
		if (this.extraFaces != null) for (face in this.extraFaces) add(face, this.dirs);
		if (this.arrayValue.length == 0) add("", this.dirs);
	}
}
