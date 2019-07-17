package arpx.impl.heaps.audio;

#if (arp_audio_backend_heaps || arp_backend_display)

import arpx.audio.UrlAudio;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.audio.AudioChannel;
import arpx.impl.cross.audio.AudioContext;
import arpx.impl.cross.audio.IAudioImpl;

class UrlAudioImpl extends ArpObjectImplBase implements IAudioImpl {

	private var audio:UrlAudio;

	public function new(audio:UrlAudio) {
		super();
		this.audio = audio;
	}

	override public function arpHeatUpNow():Bool {
		// TODO
		return true;
	}

	override public function arpHeatDownNow():Bool {
		// TODO
		return true;
	}

	public function play(context:AudioContext, loop:Bool, volume:Float):AudioChannel {
		// TODO
		return null;
	}
}

#end
