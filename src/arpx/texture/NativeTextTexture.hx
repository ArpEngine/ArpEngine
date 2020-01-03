package arpx.texture;

import arpx.impl.cross.texture.NativeTextTextureImpl;
import arpx.structs.ArpColor;
import arpx.texture.decorators.MultiTexture;

@:arpType("texture", "nativeText")
class NativeTextTexture extends MultiTexture
{
	@:arpField public var font:String = "_sans";
	@:arpField public var fontSize:Int = 12;
	@:arpField public var color:ArpColor; // FIXME

	@:arpImpl private var arpImpl:NativeTextTextureImpl;

	public function new() super();
}
