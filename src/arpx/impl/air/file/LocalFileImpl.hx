package arpx.impl.air.file;

#if (arp_file_backend_air || arp_backend_display)

import flash.utils.ByteArray;
import haxe.io.BytesInput;
import arp.io.InputWrapper;
import flash.errors.IOError;
import arp.io.IInput;
import arpx.file.LocalFile;
import arpx.impl.cross.file.IFileImpl;
import haxe.io.Bytes;

class LocalFileImpl extends ArpObjectImplBase implements IFileImpl {

	private var file:LocalFile;
	private var nativeFile:File;
	private var value:Bytes;

	public function new(file:LocalFile) {
		super();
		this.file = file;
		this.nativeFile = File.applicationDirectory.resolvePath(this.file.src);
	}

	override public function arpHeatUpNow():Bool {
		if (!this.exists) return;
		var stream:FileStream = new FileStream();
		try {
			stream.open(file, "read");
			var bytes:ByteArray = new ByteArray();
			stream.readBytes(bytes);
			this.value = Bytes.ofData(bytes);
		} catch (e:IOError) {
		}
	}

	override public function arpHeatDownNow():Bool {
		this.value = null;
		return true;
	}

	public var exists(get, never):Bool;
	private function get_exists():Bool {
		return this.nativeFile.exists;
	}

	public function bytes():Bytes {
		return this.value;
	}

	public function read():IInput {
		return new InputWrapper(new BytesInput(this.value));
	}
}

@:native("flash.filesystem.File")
extern class File {
	function new();
	static var applicationDirectory:File;
	var exists:Bool;
	function resolvePath(path:String):File;
}

@:native("flash.filesystem.FileStream")
extern class FileStream {
	function new();
	function open(file:File, fileMode:String):Void;
	function readBytes(bytes:ByteArray, offset:UInt = 0, length:UInt = 0):Void;
}

@:native("flash.filesystem.FileMode")
extern class FileMode {
	static var READ:String;
}
#end
