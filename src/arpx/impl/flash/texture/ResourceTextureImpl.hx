package arpx.impl.flash.texture;

#if (arp_display_backend_flash || arp_backend_display)

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.events.IOErrorEvent;
import haxe.io.Bytes;
import haxe.Resource;
import arpx.impl.cross.texture.ITextureImpl;
import arpx.impl.cross.texture.TextureImplBase;
import arpx.impl.flash.texture.TextureFaceDataImpl;
import arpx.structs.IArpParamsRead;
import arpx.texture.ResourceTexture;

class ResourceTextureImpl extends TextureImplBase implements ITextureImpl {

	private var texture:ResourceTexture;
	private var loader:Loader;
	private var value:BitmapData;

	override private function get_width():Int return this.value.width;
	override private function get_height():Int return this.value.height;

	public function new(texture:ResourceTexture) {
		super();
		this.texture = texture;
	}

	override public function arpHeatUp():Bool {
		if (this.value != null) return true;

		if (this.loader == null) {
			var bytes:Bytes = Resource.getBytes(texture.src);
			this.loader = new Loader();
			this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoadComplete);
			this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onLoadError);
			this.loader.loadBytes(bytes.getData());
		}
		this.texture.arpDomain.waitFor(this.texture);
		return false;
	}

	private function onLoadError(event:IOErrorEvent):Void {
		this.texture.arpDomain.notifyFor(this.texture);
	}

	private function onLoadComplete(event:Event):Void {
		this.value = cast(this.loader.content, Bitmap).bitmapData;
		this.texture.arpDomain.notifyFor(this.texture);
	}

	override public function arpHeatDown():Bool {
		this.loader = null;
		this.value = null;
		return true;
	}

	public function getFaceData(params:IArpParamsRead = null):TextureFaceDataImpl {
		return new TextureFaceDataImpl(this.value);
	}
}

#end
