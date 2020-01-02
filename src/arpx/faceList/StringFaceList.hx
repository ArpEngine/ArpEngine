package arpx.faceList;

import arp.ds.ISet;
import arp.iterators.ERegIterator;

@:arpType("faceList", "string")
class StringFaceList extends ArrayFaceList {

	@:arpField public var format:String;
	@:arpField public var unique:Bool;
	@:arpField public var value:ISet<String>;

	public function new() super();

	override private function populate():Void {
		var chars:Map<String, Bool> = new Map();
		for (v in this.value) {
			switch (format) {
				case "csv":
					for (face in ~/\s/g.replace(v, "").split(",")) {
						if (!chars.exists(face)) {
							this.add(face, 1);
							if (unique) chars.set(face, true);
						}
					}
				case _:
					for (face in new ERegIterator(~/[^\n\r\t\/ ]|\/[^\/]*\//, v)) {
						if (!chars.exists(face)) {
							this.add(face, 1);
							if (unique) chars.set(face, true);
						}
					}
			}
		}
	}
}
