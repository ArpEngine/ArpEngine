package arpx.impl.stub.display;

#if (arp_display_backend_stub || arp_backend_display)

import arpx.impl.cross.display.DisplayContextBase;
import arpx.impl.cross.display.IDisplayContext;
import arpx.impl.cross.display.IRenderContext;
import arpx.impl.cross.structs.ArpTransform;
import arpx.impl.cross.texture.TextureFaceData;
import arpx.structs.ArpColor;

class DisplayContextImpl extends DisplayContextBase implements IDisplayContext implements IRenderContext {

	private var _width:Int;
	public var width(get, null):Int;
	private function get_width():Int return _width;
	private var _height:Int;
	public var height(get, null):Int;
	private function get_height():Int return _height;

	public function new(width:Int, height:Int, transform:ArpTransform = null, clearColor:UInt = 0) {
		super(transform, clearColor);
		this._width = width;
		this._height = height;
	}

	public function start():Void return;
	public function display():Void return;
	public function fillRect(l:Int, t:Int, w:Int, h:Int, color:ArpColor):Void return;
	public function fillFace(faceData:TextureFaceData, color:ArpColor, hasAlpha:Bool, smoothing:Bool):Void return;

	inline public function renderContext():RenderContext return new RenderContext(this);
}

#end
