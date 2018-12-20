package arpx.impl.js.audio;

#if (arp_audio_backend_js || arp_backend_display)

import js.html.ArrayBuffer;
import js.html.audio.AudioBuffer;
import js.html.audio.AudioContext;
import js.Browser;

class AudioContextImpl {

	public var raw(default, null):AudioContext;
	public var dummyBuffer(default, null):AudioBuffer;
	public var preferredExtension(default, null):String;

	public function new() {
		this.raw = try { new AudioContext(); } catch (_:Dynamic) { untyped __js__("new webkitAudioContext()"); };
		this.dummyBuffer = this.raw.createBuffer(1, 1, 44100);
		this.preferredExtension = switch (Browser.navigator.userAgent) {
			case ua if (ua.indexOf("Chrome") >= 0): "ogg";
			case ua if (ua.indexOf("Safari") >= 0): "m4a";
			case _: "ogg";
		}

		// magic for iOS browser
		Browser.document.addEventListener("touchend", onTouchEvent);
	}

	private function onTouchEvent():Void {
		var source = this.raw.createBufferSource();
		source.buffer = dummyBuffer;
		source.connect(this.raw.destination);
		source.start();
	}

	public function decodeAudioData(buffer:ArrayBuffer, callback:Null<AudioBuffer>->Void):Void {
		raw.decodeAudioData(buffer, callback, () -> callback(null));
	}
}

#end
