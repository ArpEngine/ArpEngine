package arpx.impl.heaps.audio;

#if (arp_audio_backend_heaps || arp_backend_display)

import hxd.snd.Channel;

@:forward(volume)
abstract AudioChannelImpl(Channel) from Channel {

	public var isPlaying(get, never):Bool;
	inline private function get_isPlaying():Float return @:privateAccess this.manager != null;

	public var position(get, never):Float;
	inline private function get_position():Float return this.position;

	public var onComplete(get, set):Void->Void;
	inline private function get_onComplete():Void->Void return this.onEnd;
	inline private function set_onComplete(callback:Void->Void):Void->Void return this.onEnd = callback;

	inline public function new(channel:Channel) this = channel;

	inline public function stop():Void this.stop();
}

#end
