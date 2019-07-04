package arpx.file;

import arpx.impl.cross.file.LocalFileImpl;

@:arpType("file", "local")
class LocalFile extends File {

	@:arpField public var src:String;

	@:arpImpl private var arpImpl:LocalFileImpl;

	public function new () {
		super();
	}
}
