package arpx.faceList;

import arp.ds.ISet;
import arp.iterators.ERegIterator;
import arpx.text.TextData;

@:arpType("faceList", "text")
class TextDataFaceList extends ArrayFaceList {

	@:arpField public var format:String;
	@:arpField(true) public var texts:ISet<TextData>;
	@:arpField public var unique:Bool;

	public function new() super();

	override private function populate():Void {
		var chars:Map<String, Bool> = new Map();
		for (v in texts) {
			var text:String = v.publish();
			switch (format) {
				case "csv":
					for (face in ~/\s/g.replace(text, "").split(",")) {
						if (!chars.exists(face)) {
							this.add(face, 1);
							if (unique) chars.set(face, true);
						}
					}
				case _:
					for (face in new ERegIterator(~/[^\n\r\t\/ ]|\/[^\/]*\//, text)) {
						if (!chars.exists(face)) {
							this.add(face, 1);
							if (unique) chars.set(face, true);
						}
					}
			}
		}
	}
}
