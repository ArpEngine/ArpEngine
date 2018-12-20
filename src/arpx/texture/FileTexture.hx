package arpx.texture;

import arpx.file.File;
import arpx.impl.cross.texture.FileTextureImpl;

@:arpType("texture", "file")
class FileTexture extends Texture
{
	@:arpField @:arpBarrier public var file:File;

	@:arpImpl private var arpImpl:FileTextureImpl;

	public function new() super();
}
