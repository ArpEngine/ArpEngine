package arpx.audio;

import arp.domain.IArpObject;

import arpx.impl.cross.audio.IAudioImpl;

@:arpType("audio", "null")
class Audio implements IArpObject implements IAudioImpl {

	@:arpImpl private var arpImpl:IAudioImpl;

	public function new() return;
}
