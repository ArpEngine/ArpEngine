package arpx.impl.cross.storage;

import haxe.io.Bytes;
import arp.impl.IArpObjectImpl;

interface IStorageImpl extends IArpObjectImpl {
	var bytes(get, set):Null<Bytes>;
}
