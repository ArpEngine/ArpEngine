package arpx.impl.js.audio;

#if (arp_audio_backend_js || arp_backend_display)

import arpx.audio.ResourceAudio;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.audio.AudioContext;
import arpx.impl.cross.audio.IAudioImpl;
import haxe.io.Bytes;
import haxe.Resource;
import js.html.audio.AudioBuffer;
import js.html.audio.AudioBufferSourceNode;

class ResourceAudioImpl extends ArpObjectImplBase implements IAudioImpl {

	private var audio:ResourceAudio;
	private var buffer:AudioBuffer;

	public function new(audio:ResourceAudio) {
		super();
		this.audio = audio;
	}

	override public function arpHeatUp():Bool {
		var contextImpl:AudioContextImpl = AudioContext.instance.impl;
		var bytes:Bytes = Resource.getBytes(this.audio.src);
		this.buffer = contextImpl.dummyBuffer;
		contextImpl.decodeAudioData(bytes.getData(), this.onDecoded);
		this.audio.arpDomain.waitFor(this.audio);
		return false;
	}

	private function onDecoded(buf:Null<AudioBuffer>):Void {
		var contextImpl:AudioContextImpl = AudioContext.instance.impl;
		if (this.buffer == contextImpl.dummyBuffer) this.buffer = buf;
		this.audio.arpDomain.notifyFor(this.audio);
	}

	override public function arpHeatDown():Bool {
		this.buffer = null;
		return true;
	}

	public function play(context:AudioContext):AudioChannelImpl {
		var nativeContext:js.html.audio.AudioContext = context.impl.raw;
		var source:AudioBufferSourceNode = nativeContext.createBufferSource();
		source.buffer = this.buffer;
		return new AudioChannelImpl(context, source);
	}
}

#end
