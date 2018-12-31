package arpx.impl.heaps.audio;

#if (arp_audio_backend_heaps || arp_backend_display)

import arpx.audio.UrlAudio;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.audio.AudioContext;
import arpx.impl.cross.audio.IAudioImpl;

class UrlAudioImpl extends ArpObjectImplBase implements IAudioImpl {

	private var audio:UrlAudio;

	public function new(audio:UrlAudio) {
		super();
		this.audio = audio;
	}

	override public function arpHeatUp():Bool {
		// TODO
		return true;
	}

	override public function arpHeatDown():Bool {
		// TODO
		return true;
	}

	public function play(context:AudioContext):AudioChannelImpl {
		// TODO
		return null;
	}
}

#end
