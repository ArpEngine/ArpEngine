package arpx.file;

import arpx.impl.cross.file.UrlFileImpl;

@:arpType("file", "url")
class UrlFile extends File {

	@:arpField public var src:String;

	@:arpImpl private var arpImpl:UrlFileImpl;

	public function new () {
		super();
	}
}
