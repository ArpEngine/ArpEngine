package arpx.impl.cross.audio;

@:forward(position, isPlaying, volume, stop, onComplete)
abstract AudioChannel(AudioChannelImpl) from AudioChannelImpl {
	inline public function new(impl:AudioChannelImpl) this = impl;
}
