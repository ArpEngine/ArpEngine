package arpx.impl.js.audio;

#if (arp_audio_backend_js || arp_backend_display)

import js.html.audio.GainNode;
import js.html.audio.AudioBufferSourceNode;
import js.html.audio.AudioBuffer;
import arpx.impl.cross.audio.AudioContext;

class AudioChannelImpl {

	private var startTime:Float;
	private var buffer:AudioBuffer;
	private var source:AudioBufferSourceNode;
	private var gain:GainNode;

	public var isPlaying(get, never):Bool;
	inline private function get_isPlaying():Bool return this.position < this.buffer.duration;

	public var position(get, never):Float;
	inline private function get_position():Float return AudioContext.instance.impl.raw.currentTime - this.startTime;

	public var volume(get, set):Float;
	inline private function get_volume():Float return this.gain.gain.value;
	inline private function set_volume(value:Float):Float return this.gain.gain.value = value;

	public var onComplete(get, set):Void->Void;
	inline private function get_onComplete():Void->Void return untyped this.source.onended;
	inline private function set_onComplete(callback:Void->Void):Void->Void return untyped this.source.onended = callback;

	public function new(context:AudioContext, buffer:AudioBuffer, loop:Bool, volume:Float) {
		var nativeContext:js.html.audio.AudioContext = context.impl.raw;
		this.buffer = buffer;
		this.source = nativeContext.createBufferSource();
		this.source.loop = loop;
		this.source.buffer = this.buffer;
		this.gain = nativeContext.createGain();
		this.gain.gain.value = volume;
		this.source.connect(this.gain);
		this.gain.connect(nativeContext.destination);
		this.startTime = nativeContext.currentTime;
		source.start();
	}

	public function stop():Void {
		this.source.onended = null;
		this.source.stop();
	}
}

#end
