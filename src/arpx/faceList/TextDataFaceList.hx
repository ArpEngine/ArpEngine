package arpx.faceList;

import arp.ds.ISet;
import arp.ds.proxy.SetProxy;
import arpx.text.TextData;

@:arpType("faceList", "text")
class TextDataFaceList extends FaceList {

	@:arpField public var dirs:Int = 1;
	@:arpField public var format:String;
	@:arpField public var unique:Bool;

	@:arpField(true) public var texts:ISet<TextData>;

	public function new() super();

	override private function populate(add:(face:String, size:Int)->Void):Void {
		StringFaceList.populateFromStringIterable(new SetProxy(this.texts, (v:TextData) -> v.publish()), this.format, this.dirs, add, if (this.unique) this.faceSpan else _ -> null);
	}
}
