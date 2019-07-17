package arpx.impl.js.file;

#if (arp_file_backend_js || arp_backend_display)

import js.html.XMLHttpRequest;
import arp.io.IInput;
import arp.io.InputWrapper;
import arpx.file.UrlFile;
import arpx.impl.cross.file.IFileImpl;
import haxe.io.Bytes;
import haxe.io.BytesInput;

class UrlFileImpl extends ArpObjectImplBase implements IFileImpl {

	private var file:UrlFile;
	private var xhr:XMLHttpRequest;
	private var value:Bytes;

	public function new(file:UrlFile) {
		super();
		this.file = file;
	}

	override public function arpHeatUpNow():Bool {
		if (xhr != null) return this.file != null;

		this.xhr = new XMLHttpRequest();
		xhr.open("GET", this.file.src, true);
		xhr.responseType = untyped "arraybuffer";
		xhr.onload = this.onLoaded;
		xhr.onerror = this.onError;
		this.file.arpDomain.waitFor(this.file);
		xhr.send();
		return false;
	}

	private function onLoaded():Void {
		if (this.xhr != null) this.value = Bytes.ofData(xhr.response);
		this.file.arpDomain.notifyFor(this.file);
	}

	private function onError():Void {
		this.file.arpDomain.notifyFor(this.file);
	}

	override public function arpHeatDownNow():Bool {
		if (this.xhr == null) return true;

		this.xhr.onload = null;
		this.xhr.onerror = null;
		this.xhr = null;
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
