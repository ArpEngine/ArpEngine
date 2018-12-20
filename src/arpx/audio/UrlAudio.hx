package arpx.audio;

import arpx.impl.cross.audio.UrlAudioImpl;

@:arpType("audio", "url")
class UrlAudio extends Audio {
	@:arpField public var src:String;

	@:arpImpl private var arpImpl:UrlAudioImpl;

	public function new() super();
}
