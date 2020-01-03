package arpx.faceList;

import arp.ds.ISet;
import arp.iterators.ERegIterator;

@:arpType("faceList", "string")
class StringFaceList extends FaceList {

	@:arpField public var dirs:Int = 1;
	@:arpField public var format:String;
	@:arpField public var unique:Bool;

	@:arpField public var value:ISet<String>;

	public function new() super();

	override private function populate(add:(face:String, size:Int)->Void):Void {
		var chars:Map<String, Bool> = new Map();
		for (v in this.value) {
			switch (format) {
				case "csv":
					for (face in ~/\s/g.replace(v, "").split(",")) {
						if (!chars.exists(face)) {
							add(face, this.dirs);
							if (unique) chars.set(face, true);
						}
					}
				case _:
					for (face in new ERegIterator(~/[^\n\r\t\/ ]|\/[^\/]*\//, v)) {
						if (!chars.exists(face)) {
							add(face, this.dirs);
							if (unique) chars.set(face, true);
						}
					}
			}
		}
	}
}
