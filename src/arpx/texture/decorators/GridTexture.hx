package arpx.texture.decorators;

import arpx.faceList.FaceList;
import arpx.impl.cross.texture.decorators.GridTextureImpl;

@:arpType("texture", "grid")
class GridTexture extends MultiTexture {

	@:arpField(readonly) public var width:Int;
	@:arpField(readonly) public var height:Int;

	@:arpBarrier(true) @:arpField public var faceList:FaceList;
	@:arpField public var dirs:Int = 1;
	@:arpField public var offset:Int = 0;

	@:arpImpl private var arpImpl:GridTextureImpl;

	public function new() super();
}
