package arpx.impl.sys.audio;

#if (arp_audio_backend_sys || arp_backend_display)

import arpx.impl.cross.audio.AudioContext;
import arpx.impl.cross.audio.IAudioImpl;
import arpx.audio.ResourceAudio;

class ResourceAudioImpl extends ArpObjectImplBase implements IAudioImpl {

	private var audio:ResourceAudio;

	public function new(audio:ResourceAudio) {
		super();
		this.audio = audio;
	}

	public function play(context:AudioContext):AudioChannel return new AudioChannel();
}

#end
