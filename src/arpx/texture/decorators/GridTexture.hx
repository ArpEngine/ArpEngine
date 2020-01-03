package arpx.texture.decorators;

import arpx.impl.cross.texture.decorators.GridTextureImpl;

@:arpType("texture", "grid")
class GridTexture extends MultiTexture {

	@:arpField(readonly) public var width:Int;
	@:arpField(readonly) public var height:Int;

	@:arpField public var isVertical:Bool;

	@:arpImpl private var arpImpl:GridTextureImpl;

	public function new() super();
}
