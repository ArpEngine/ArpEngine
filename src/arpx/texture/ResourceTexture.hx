package arpx.texture;

import arpx.impl.cross.texture.ResourceTextureImpl;

@:arpType("texture", "resource")
class ResourceTexture extends Texture
{
	@:arpField public var src:String;

	@:arpImpl private var arpImpl:ResourceTextureImpl;

	public function new() super();
}
