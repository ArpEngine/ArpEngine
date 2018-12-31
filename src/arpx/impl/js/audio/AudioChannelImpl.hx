package arpx.impl.js.audio;

#if (arp_audio_backend_js || arp_backend_display)

import arpx.impl.cross.audio.AudioContext;
import js.html.audio.AudioScheduledSourceNode;

class AudioChannelImpl {

	private var source:AudioScheduledSourceNode;

	public function new(context:AudioContext, channel:AudioScheduledSourceNode) {
		var nativeContext:js.html.audio.AudioContext = context.impl.raw;
		source.connect(nativeContext.destination);
		source.start();
		return new AudioChannelImpl();

		this.source = channel;
	}

	public function stop():Void {
		this.source.stop();
	}
}

#end
