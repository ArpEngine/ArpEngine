package arpx.impl.flash.display;

#if (arp_display_backend_flash || arp_backend_display)

import arpx.impl.cross.display.DisplayContextBase;
import arpx.impl.cross.display.IDisplayContext;
import arpx.impl.cross.display.IRenderContext;
import arpx.impl.cross.geom.PointImpl;
import arpx.impl.cross.structs.ArpTransform;
import arpx.impl.cross.texture.TextureFaceData;
import arpx.structs.ArpColor;
import flash.display.BitmapData;
import flash.display.BlendMode;
import flash.geom.Rectangle;

class DisplayContextImpl extends DisplayContextBase implements IDisplayContext implements IRenderContext {

	public var bitmapData(default, null):BitmapData;

	public var width(get, never):Int;
	private function get_width():Int return bitmapData.width;
	public var height(get, never):Int;
	private function get_height():Int return bitmapData.height;

	public function new(bitmapData:BitmapData, transform:ArpTransform = null, clearColor:ArpColor = null) {
		super(transform, clearColor);
		this.bitmapData = bitmapData;
	}

	public function start():Void this.bitmapData.fillRect(this.bitmapData.rect, clearColor.value32);
	public function display():Void return;

	private var _workRect:Rectangle = new Rectangle();
	inline public function fillRect(l:Int, t:Int, w:Int, h:Int):Void {
		var workRect:Rectangle = this._workRect;
		workRect.setTo(this.transform.impl.tx + l, this.transform.impl.ty + t, w, h);
		this.bitmapData.fillRect(workRect, this.tint.value32);
	}

	private var _workPt:PointImpl = PointImpl.alloc();
	public function fillFace(faceData:TextureFaceData, hasAlpha:Bool, smoothing:Bool):Void {
		var pt:PointImpl = transform.asPoint(_workPt);
		if (pt != null && (this.tint.value32 == 0xffffffff)) {
			bitmapData.copyPixels(faceData.source, faceData.bound, pt.raw, null, null, hasAlpha);
		} else {
			bitmapData.draw(faceData.trimmed, transform.impl.raw, this.tint.toMultiplier(), BlendMode.NORMAL, null, smoothing);
		}
	}

	inline public function renderContext():RenderContext return new RenderContext(this);
}

#end
