package arpx.impl.flash.audio;

#if (arp_audio_backend_flash || arp_backend_display)

import flash.media.SoundChannel;

abstract AudioChannelImpl(SoundChannel) from SoundChannel {

	inline public function new(channel:SoundChannel) this = channel;

	inline public function stop():Void this.stop();
}

#end
