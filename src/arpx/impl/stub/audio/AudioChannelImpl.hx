package arpx.impl.stub.audio;

#if (arp_audio_backend_stub || arp_backend_display)

class AudioChannelImpl {

	public var volume:Float = 1.0;

	public function new(volume:Float) {
		this.volume = volume;
	}

	public function stop():Void return;
}

#end
