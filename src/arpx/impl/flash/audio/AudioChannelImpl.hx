package arpx.impl.flash.audio;

#if (arp_audio_backend_flash || arp_backend_display)

import flash.media.SoundChannel;

abstract AudioChannelImpl(SoundChannel) from SoundChannel {

	public var volume(get, set):Float;
	inline private function get_volume():Float return this.soundTransform.volume;
	inline private function set_volume(value:Float):Float return this.soundTransform.volume = value;

	inline public function new(channel:SoundChannel) this = channel;

	inline public function stop():Void this.stop();
}

#end
