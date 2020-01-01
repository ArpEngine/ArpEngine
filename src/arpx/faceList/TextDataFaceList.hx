package arpx.faceList;

import arp.ds.ISet;
import arp.iterators.ERegIterator;
import arpx.text.TextData;

@:arpType("faceList", "text")
class TextDataFaceList extends ArrayFaceList {

	@:arpField public var isVertical:Bool;

	@:arpField public var format:String;
	@:arpField(true) public var texts:ISet<TextData>;
	@:arpField public var unique:Bool;

	public function new() super();

	override private function heatUp():Bool {
		if (!super.heatUp()) return false;
		var chars:Map<String, Bool> = new Map();
		for (v in texts) {
			var text:String = v.publish();
			switch (format) {
				case "csv":
					for (face in ~/\s/g.replace(text, "").split(",")) this.add(face, 1, isVertical);
				case _:
					for (face in new ERegIterator(~/[^\n\r\t\/ ]|\/[^\/]*\//, text)) this.add(face, 1, isVertical);
			}
		}
		return true;
	}
}
