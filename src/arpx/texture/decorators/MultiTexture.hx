package arpx.texture.decorators;

@:arpType("texture", "multi")
class MultiTexture extends Texture {
	@:arpBarrier(true) @:arpField public var texture:Texture;

	@:arpField public var offset:Int = 0;

	public function new () {
		super();
	}
}
