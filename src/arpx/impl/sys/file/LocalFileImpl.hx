package arpx.impl.sys.file;

#if (arp_file_backend_sys || arp_backend_display)

import sys.io.File;
import haxe.io.BytesInput;
import arp.io.InputWrapper;
import sys.FileSystem;
import arp.io.IInput;
import arpx.file.LocalFile;
import arpx.impl.cross.file.IFileImpl;
import haxe.io.Bytes;

class LocalFileImpl extends ArpObjectImplBase implements IFileImpl {

	private var file:LocalFile;
	private var value:Bytes;

	public function new(file:LocalFile) {
		super();
		this.file = file;
	}

	override public function arpHeatUpNow():Bool {
		if (!this.exists) return true;
		this.value = File.getBytes(file.src);
		return true;
	}

	override public function arpHeatDownNow():Bool {
		this.value = null;
		return true;
	}

	public var exists(get, never):Bool;
	private function get_exists():Bool {
		return FileSystem.exists(file.src);
	}

	public function bytes():Bytes {
		return this.value;
	}

	public function read():IInput {
		return new InputWrapper(new BytesInput(this.value));
	}
}

#end
