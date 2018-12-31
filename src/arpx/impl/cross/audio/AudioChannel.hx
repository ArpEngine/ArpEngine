package arpx.impl.cross.audio;

@:forward(volume, stop)
abstract AudioChannel(AudioChannelImpl) from AudioChannelImpl {
	inline public function new(impl:AudioChannelImpl) this = impl;
}
