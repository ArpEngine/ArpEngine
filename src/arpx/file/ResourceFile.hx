package arpx.file;

import arpx.impl.cross.file.ResourceFileImpl;

@:arpType("file", "resource")
class ResourceFile extends File {

	@:arpField public var src:String;

	@:arpImpl private var flashImpl:ResourceFileImpl;

	public function new () {
		super();
	}
}
