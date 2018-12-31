package arpx.impl.heaps.audio;

#if (arp_audio_backend_heaps || arp_backend_display)

import hxd.snd.Channel;

abstract AudioChannelImpl(Channel) from Channel {

	inline public function new(channel:Channel) this = channel;

	inline public function stop():Void this.stop();
}

#end
