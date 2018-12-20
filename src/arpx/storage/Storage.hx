package arpx.storage;

import arp.domain.IArpObject;
import arpx.impl.cross.storage.IStorageImpl;

@:arpType("storage", "null")
class Storage implements IStorageImpl implements IArpObject {

	@:arpImpl private var impl:IStorageImpl;

	public function new () {
	}
}
