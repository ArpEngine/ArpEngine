package arpx.texture.decorators;

import arpx.faceList.FaceList;

@:arpType("texture", "multi")
class MultiTexture extends Texture {

	@:arpBarrier(true) @:arpField public var texture:Texture;
	@:arpBarrier(true) @:arpField public var faceList:FaceList;

	@:arpField public var offset:Int = 0;

	public function new () {
		super();
	}
}
