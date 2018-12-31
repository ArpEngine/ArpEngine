package arpx.impl.js.audio;

#if (arp_audio_backend_js || arp_backend_display)

import arpx.audio.UrlAudio;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.audio.AudioChannel;
import arpx.impl.cross.audio.AudioContext;
import arpx.impl.cross.audio.IAudioImpl;
import js.html.audio.AudioBuffer;
import js.html.XMLHttpRequest;

class UrlAudioImpl extends ArpObjectImplBase implements IAudioImpl {

	private var audio:UrlAudio;
	private var xhr:XMLHttpRequest;
	private var buffer:AudioBuffer;

	public function new(audio:UrlAudio) {
		super();
		this.audio = audio;
	}

	private var src(get, never):String;
	private function get_src():String {
		var a:Array<String> = audio.src.split(".");
		var extension:String = if (a.length == 1) null else a.pop();
		a.push(AudioContext.instance.impl.preferredExtension);
		return a.join(".");
	}

	override public function arpHeatUp():Bool {
		if (xhr != null) return this.audio != null;

		this.xhr = new XMLHttpRequest();
		xhr.open("GET", this.src, true);
		xhr.responseType = untyped "arraybuffer";
		xhr.onload = this.onLoaded;
		xhr.onerror = this.onError;
		this.audio.arpDomain.waitFor(this.audio);
		xhr.send();
		return false;
	}

	private function onLoaded():Void {
		var contextImpl:AudioContextImpl = AudioContext.instance.impl;
		contextImpl.decodeAudioData(xhr.response, this.onDecoded);
	}

	private function onDecoded(buf:Null<AudioBuffer>):Void {
		if (this.xhr != null) this.buffer = buf;
		this.audio.arpDomain.notifyFor(this.audio);
	}

	private function onError():Void {
		this.audio.arpDomain.notifyFor(this.audio);
	}

	override public function arpHeatDown():Bool {
		if (this.buffer == null) return true;
		this.xhr.onload = null;
		this.xhr.onerror = null;
		this.xhr = null;
		this.buffer = null;
		return true;
	}

	public function play(context:AudioContext, volume:Float):AudioChannel {
		return new AudioChannelImpl(context, this.buffer, volume);
	}
}

#end
