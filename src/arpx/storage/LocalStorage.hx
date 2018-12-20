package arpx.storage;

import arpx.impl.cross.storage.LocalStorageImpl;

@:arpType("storage", "local")
class LocalStorage extends Storage {

	@:arpField public var src:String;

	@:arpImpl private var arpImpl:LocalStorageImpl;

	public function new() super();
}
