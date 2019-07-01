package arpx.impl.flash.file;

#if (arp_file_backend_flash || arp_backend_display)

import arp.io.IInput;
import arp.io.InputWrapper;
import arpx.file.UrlFile;
import arpx.impl.cross.file.IFileImpl;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import haxe.io.Bytes;
import haxe.io.BytesInput;

class UrlFileImpl extends ArpObjectImplBase implements IFileImpl {

	private var file:UrlFile;
	private var loader:URLLoader;
	private var value:Bytes;

	public function new(file:UrlFile) {
		super();
		this.file = file;
	}

	override public function arpHeatUp():Bool {
		if (this.loader != null) return this.value != null;
		this.loader = new URLLoader();
		this.loader.dataFormat = URLLoaderDataFormat.BINARY;
		this.loader.addEventListener(Event.COMPLETE, this.onLoadComplete);
		this.loader.addEventListener(IOErrorEvent.IO_ERROR, this.onLoadError);
		this.loader.load(new URLRequest(this.file.src));
		this.file.arpDomain.waitFor(this.file);
		return false;
	}

	private function onLoadComplete(event:Event):Void {
		this.value = Bytes.ofData(this.loader.data);
		this.file.arpDomain.notifyFor(this.file);
	}

	private function onLoadError(event:IOErrorEvent):Void {
		this.file.arpDomain.notifyFor(this.file);
	}

	override public function arpHeatDown():Bool {
		if (this.loader == null) return true;

		this.loader.removeEventListener(Event.COMPLETE, this.onLoadComplete);
		this.loader.removeEventListener(IOErrorEvent.IO_ERROR, this.onLoadError);
		this.loader = null;
		this.value = null;
		return true;
	}

	public var exists(get, never):Bool;
	private function get_exists():Bool {
		return this.value != null;
	}

	public function bytes():Bytes {
		return this.value;
	}

	public function read():IInput {
		return new InputWrapper(new BytesInput(this.value));
	}
}

#end
