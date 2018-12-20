package arpx.faceList;

import arp.iterators.ERegIterator;
import arpx.structs.ArpRange;

@:arpType("faceList", "faceList")
class GenericFaceList extends ArrayFaceList {

	@:arpField public var extraFaces:Array<String>;
	@:arpField public var chars:String;
	@:arpField public var range:ArpRange;
	@:arpField("value") public var csvFaces:String;

	public function new() super();

	override private function heatUp():Bool {
		if (!super.heatUp()) return false;
		var arrayValue:Array<String> = this.arrayValue;
		if (this.chars != null) for (face in new ERegIterator(~/[^\n\r\t\/ ]|\/[^\/]*\//, this.chars)) this.add(face);
		if (this.range.hasValue) for (face in this.range.split()) this.add(face);
		if (this.csvFaces != null) for (face in ~/\s/g.replace(this.csvFaces, "").split(",")) this.add(face);
		if (this.extraFaces != null) for (face in this.extraFaces) this.add(face);
		if (arrayValue.length == 0) this.add("");
		return true;
	}
}
