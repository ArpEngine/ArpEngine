package arpx.impl.cross.texture;

import arpx.impl.cross.geom.RectImpl;
import arpx.impl.ArpObjectImplBase;
import arpx.structs.IArpParamsRead;

class TextureImplBase extends ArpObjectImplBase {

	public var width(get, never):Float;
	private function get_width():Float return 0;
	public var height(get, never):Float;
	private function get_height():Float return 0;

	public function widthOf(params:IArpParamsRead = null):Float return this.width;
	public function heightOf(params:IArpParamsRead = null):Float return this.height;
	public function layoutSize(params:IArpParamsRead, rect:RectImpl):RectImpl {
		rect.reset(0, 0, this.width, this.height);
		return rect;
	}

	public function getFaceIndex(params:IArpParamsRead = null):Int return 0;

	public function new() super();
}
