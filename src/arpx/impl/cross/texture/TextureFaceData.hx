package arpx.impl.cross.texture;

@:forward(width, height, layoutSize, source, bound, trimmed, trim, dispose)
abstract TextureFaceData(TextureFaceDataImpl) from TextureFaceDataImpl {
	public var impl(get, never):TextureFaceDataImpl;
	inline private function get_impl():TextureFaceDataImpl return this;

	inline public function new(impl:TextureFaceDataImpl) this = impl;
}
