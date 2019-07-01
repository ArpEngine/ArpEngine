package arpx.impl.stub.file;

#if (arp_file_backend_stub || arp_backend_display)

import arp.io.IInput;
import arpx.file.LocalFile;
import arpx.impl.cross.file.IFileImpl;
import haxe.io.Bytes;

class LocalFileImpl extends ArpObjectImplBase implements IFileImpl {

	private var file:LocalFile;

	public function new(file:LocalFile) {
		super();
		this.file = file;
	}

	public var exists(get, never):Bool;
	private function get_exists():Bool {
		return false;
	}

	public function bytes():Bytes {
		return null;
	}

	public function read():IInput {
		return null;
	}
}

#end
