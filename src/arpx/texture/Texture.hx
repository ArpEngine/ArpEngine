package arpx.texture;

import arp.domain.IArpObject;
import arpx.impl.cross.texture.ITextureImpl;

@:arpType("texture", "null")
class Texture implements IArpObject implements ITextureImpl {
	@:arpField public var hasAlpha:Bool = true;
	@:arpField public var smoothing:Bool = true;

	@:arpImpl private var arpImpl:ITextureImpl;

	public function new() return;
}
