package arpx.impl.sys.audio;

#if (arp_audio_backend_sys || arp_backend_display)

class AudioChannelImpl {

	public var volume:Float = 1.0;

	public function new(volume:Float) {
		this.volume = volume;
	}

	public function stop():Void return;
}

#end
