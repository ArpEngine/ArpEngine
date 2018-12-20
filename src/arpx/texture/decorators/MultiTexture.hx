package arpx.texture.decorators;

@:arpType("texture", "multi")
class MultiTexture extends Texture {
	@:arpBarrier(true) @:arpField public var texture:Texture;
	public function new () {
		super();
	}
}
