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
		populateFromStringIterable(this.value, this.format, this.dirs, add, if (this.unique) this.faceSpan else _ -> null);
	}

	public static function populateFromStringIterable(source:Iterable<String>, format:String, dirs:Int, add:(face:String, size:Int)->Void, faceSpan:(face:String)->Null<FaceSpan>):Void {
		for (text in source) {
			switch (format) {
				case "csv":
					for (face in ~/\s/g.replace(text, "").split(",")) {
						if (faceSpan(face) == null) add(face, dirs);
					}
				case _:
					for (face in new ERegIterator(~/[^\n\r\t\/ ]|\/[^\/]*\//, text)) {
						if (faceSpan(face) == null) add(face, dirs);
					}
			}
		}
	}
}
