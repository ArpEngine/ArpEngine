package arpx.impl.js.storage;

#if (arp_storage_backend_js || arp_backend_display)

import haxe.crypto.Base64;
import haxe.io.Bytes;
import js.Browser;

import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.storage.IStorageImpl;
import arpx.storage.LocalStorage;

class LocalStorageImpl extends ArpObjectImplBase implements IStorageImpl {

	private var storage:LocalStorage;

	public function new(storage:LocalStorage) {
		super();
		this.storage = storage;
	}

	public var bytes(get, set):Null<Bytes>;
	private function get_bytes():Null<Bytes> {
		var rawData:String = Browser.window.localStorage.getItem(storage.src);
		return if (rawData != null) Base64.decode(rawData) else null;
	}
	private function set_bytes(value:Null<Bytes>):Null<Bytes> {
		if (value == null) {
			Browser.window.localStorage.removeItem(storage.src);
		} else {
			Browser.window.localStorage.setItem(storage.src, Base64.encode(value));
		}
		return value;
	}
}

#end
