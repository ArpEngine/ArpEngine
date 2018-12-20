package arpx.impl.cross.audio;

class AudioContext {

	public var impl(default, null):AudioContextImpl;

	private function new() this.impl = new AudioContextImpl();

	private static var _instance:AudioContext;
	public static var instance(get, never):AudioContext;
	private static function get_instance():AudioContext return if (_instance != null) _instance else _instance = new AudioContext();
}
