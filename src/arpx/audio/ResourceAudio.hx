package arpx.audio;

import arpx.impl.cross.audio.ResourceAudioImpl;

@:arpType("audio", "resource")
class ResourceAudio extends Audio {
	@:arpField public var src:String;

	@:arpImpl private var arpImpl:ResourceAudioImpl;

	public function new() super();
}
