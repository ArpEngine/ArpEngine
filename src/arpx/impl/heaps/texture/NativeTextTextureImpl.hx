package arpx.impl.heaps.texture;

#if (arp_display_backend_heaps || arp_backend_display)

import h2d.Font;
import h2d.Tile;
import hxd.res.FontBuilder;

import arpx.impl.cross.geom.RectImpl;
import arpx.impl.cross.texture.decorators.MultiTextureImplBase;
import arpx.impl.cross.texture.ITextureImpl;
import arpx.impl.heaps.display.CharsetCjk;
import arpx.texture.NativeTextTexture;

class NativeTextTextureImpl extends MultiTextureImplBase<NativeTextTexture> implements ITextureImpl {

	private var tile:Tile;
	private var font:Font;

	override private function get_width():Float return this.texture.fontSize;
	override private function get_height():Float return this.texture.fontSize;

	public function new(texture:NativeTextTexture) {
		super(texture);
	}

	override public function arpHeatUpNow():Bool {
		if (this.tile != null) return true;

		var chars:String = "";
		for (faceSpan in this.texture.faceList) chars += faceSpan.face;

		if (this.font == null) {
			var fontName:String = this.texture.font;
			if (fontName == null) fontName = "_sans";
			this.font = @:privateAccess new FontBuilder(fontName, this.texture.fontSize, {
				antiAliasing: false,
				chars: chars,
				kerning: true
			}).build();
			this.font.charset = CharsetCjk.instance;
		}

		for (faceSpan in this.texture.faceList) {
			this.nextFaceName(faceSpan.face);
			var charCode:Int = faceSpan.face.charCodeAt(0);
			var fontChar:FontChar = font.getChar(charCode);
			var t:Tile = fontChar.t;
			this.pushFaceInfo(new TextureFaceDataImpl(t, RectImpl.alloc(t.x, t.y, fontChar.width, t.height)));
		}

		this.tile = this.font.tile;
		return true;
	}

	override public function arpHeatDownNow():Bool {
		this.tile.dispose();
		this.tile = null;
		return true;
	}
}

#end
