package arpx.impl.heaps.display;

#if (arp_display_backend_heaps || arp_backend_display)

import arpx.impl.cross.display.DisplayContextBase;
import arpx.impl.cross.display.IDisplayContext;
import arpx.impl.cross.display.IRenderContext;
import arpx.impl.cross.structs.ArpTransform;
import arpx.impl.cross.texture.TextureFaceData;
import arpx.structs.ArpColor;
import h2d.Object;
import h2d.Tile;
import h3d.Engine;
import h3d.Matrix;

class DisplayContextImpl extends DisplayContextBase implements IDisplayContext implements IRenderContext {

	public var buf(default, null):Object;
	private var _width:Int;
	public var width(get, null):Int;
	private function get_width():Int return _width;
	private var _height:Int;
	public var height(get, null):Int;
	private function get_height():Int return _height;

	private var renderer:RendererImpl;

	private var cachedFillRectTiles:Map<UInt, Tile>;
	private var cachedFillRectTilesCount:Int;

	public function new(buf:Object, width:Int, height:Int, transform:ArpTransform = null, clearColor:UInt = 0) {
		super(transform, clearColor);
		this.buf = buf;
		this._width = width;
		this._height = height;
		this.renderer = new RendererImpl(Engine.getCurrent());
		this.cachedFillRectTiles = new Map<UInt, Tile>();
	}

	public function start():Void {
		this.buf.removeChildren();
		this.renderer.start();
	}

	public function display():Void {
		this.renderer.display();
		if (cachedFillRectTilesCount > 65536) {
			this.cachedFillRectTiles = new Map<UInt, Tile>();
			this.cachedFillRectTilesCount = 0;
		}
	}

	private var _workMatrix:ArpTransform = new ArpTransform();
	public function fillRect(l:Int, t:Int, w:Int, h:Int, color:UInt):Void {
		var _workTransform:ArpTransform = _workMatrix;
		_workTransform.impl.xx = w;
		_workTransform.impl.yy = h;
		_workTransform.impl.tx = l;
		_workTransform.impl.ty = t;
		var matrix:Matrix = dupTransform().prependTransform(_workTransform).impl.raw;
		var alpha:Float = (color >>> 24) / 0xff;
		var tile:Tile = cachedFillRectTiles.get(color);
		if (tile == null) {
			tile = Tile.fromColor(color, 1, 1, alpha);
			cachedFillRectTiles.set(color, tile);
			cachedFillRectTilesCount++;
		}
		this.renderer.renderTile(matrix, tile);
		popTransform();
	}

	public function fillFace(faceData:TextureFaceData, color:ArpColor, hasAlpha:Bool, smoothing:Bool):Void {
		var tile:Tile = faceData.impl.tile;
		var _workTransform:ArpTransform = _workMatrix;
		_workTransform.impl.xx = tile.width;
		_workTransform.impl.yy = tile.height;
		_workTransform.impl.tx = 0;
		_workTransform.impl.ty = 0;
		var matrix:Matrix = dupTransform().prependTransform(_workTransform).impl.raw;
		this.renderer.renderTile(matrix, tile, color.fred, color.fgreen, color.fblue, color.falpha);
		popTransform();
	}

	inline public function renderContext():RenderContext return new RenderContext(this);
}

#end
