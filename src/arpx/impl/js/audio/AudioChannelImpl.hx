package arpx.impl.js.audio;

#if (arp_audio_backend_js || arp_backend_display)

import js.html.audio.GainNode;
import js.html.audio.AudioBufferSourceNode;
import js.html.audio.AudioBuffer;
import arpx.impl.cross.audio.AudioContext;

class AudioChannelImpl {

	private var buffer:AudioBuffer;
	private var source:AudioBufferSourceNode;
	private var gain:GainNode;

	public var volume(get, set):Float;
	inline private function get_volume():Float return this.gain.gain.value;
	inline private function set_volume(value:Float):Float return this.gain.gain.value = value;

	public function new(context:AudioContext, buffer:AudioBuffer) {
		var nativeContext:js.html.audio.AudioContext = context.impl.raw;
		this.buffer = buffer;
		this.source = nativeContext.createBufferSource();
		this.source.buffer = this.buffer;
		this.gain = nativeContext.createGain();
		this.source.connect(this.gain);
		this.gain.connect(nativeContext.destination);
		source.start();
	}

	public function stop():Void {
		this.source.stop();
	}
}

#end
