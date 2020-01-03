package arpx.impl.flash.texture;

#if (arp_display_backend_flash || arp_backend_display)

import flash.display.BitmapData;
import flash.geom.Rectangle;
import flash.text.TextFormat;
import arpx.impl.cross.texture.decorators.MultiTextureImplBase;
import arpx.impl.cross.texture.ITextureImpl;
import arpx.impl.cross.texture.TextureFaceData;
import arpx.impl.flash.display.BitmapFont;
import arpx.impl.flash.display.BitmapFontDrawCursor;
import arpx.structs.IArpParamsRead;
import arpx.texture.NativeTextTexture;

class NativeTextTextureImpl extends MultiTextureImplBase<NativeTextTexture> implements ITextureImpl {

	private var _bitmapData:BitmapData;

	override private function get_width():Int return this.texture.fontSize;
	override private function get_height():Int return this.texture.fontSize;

	public function new(texture:NativeTextTexture) {
		super(texture);
	}

	override public function arpHeatUpNow():Bool {
		if (this.faces.length > 0) return true;

		var textFormat:TextFormat = new TextFormat(this.texture.font, this.texture.fontSize);
		var bitmapFont:BitmapFont = new BitmapFont(textFormat, 0, 0, false);
		this._bitmapData = new BitmapData(2048, 2048, true, 0xffff00ff); // FIXME

		var cursor:BitmapFontDrawCursor = new BitmapFontDrawCursor(bitmapFont, this._bitmapData.width, this._bitmapData.height);
		var faceInfo:TextureFaceData = new TextureFaceDataImpl(this._bitmapData);
		for (faceSpan in this.texture.faceList) {
			this.nextFaceName(faceSpan.face);
			var charCode:Int = faceSpan.face.charCodeAt(0);
			cursor.move(charCode);
			bitmapFont.drawChar(this._bitmapData, charCode, cursor.x, cursor.y);
			var bounds:Rectangle = bitmapFont.getBounds(charCode);
			// FIXME deal with bitmapFont.lineHeight
			this.pushFaceInfo(faceInfo.trim(cursor.x, cursor.y, bounds.width, bounds.height));
		}
		bitmapFont.dispose();
		return true;
	}

	override public function getFaceIndex(params:IArpParamsRead = null):Int return try super.getFaceIndex(params) catch (e:Dynamic) 0;

	override public function arpHeatDownNow():Bool {
		this._bitmapData.dispose();
		this._bitmapData = null;
		return true;
	}
}

#end
