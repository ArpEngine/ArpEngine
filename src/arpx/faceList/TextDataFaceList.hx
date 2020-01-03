package arpx.faceList;

import arp.ds.ISet;
import arp.iterators.ERegIterator;
import arpx.text.TextData;

@:arpType("faceList", "text")
class TextDataFaceList extends FaceList {

	@:arpField public var dirs:Int = 1;
	@:arpField public var format:String;
	@:arpField public var unique:Bool;

	@:arpField(true) public var texts:ISet<TextData>;

	public function new() super();

	override private function populate():Void {
		var chars:Map<String, Bool> = new Map();
		for (v in texts) {
			var text:String = v.publish();
			switch (format) {
				case "csv":
					for (face in ~/\s/g.replace(text, "").split(",")) {
						if (!chars.exists(face)) {
							this.add(face, this.dirs);
							if (unique) chars.set(face, true);
						}
					}
				case _:
					for (face in new ERegIterator(~/[^\n\r\t\/ ]|\/[^\/]*\//, text)) {
						if (!chars.exists(face)) {
							this.add(face, this.dirs);
							if (unique) chars.set(face, true);
						}
					}
			}
		}
	}
}
