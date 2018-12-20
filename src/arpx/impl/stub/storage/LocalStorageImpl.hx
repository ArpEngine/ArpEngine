package arpx.impl.stub.storage;

#if (arp_storage_backend_stub || arp_backend_display)

import haxe.io.Bytes;
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
	private function get_bytes():Null<Bytes> return null;
	private function set_bytes(value:Null<Bytes>):Null<Bytes> return value;
}

#end
