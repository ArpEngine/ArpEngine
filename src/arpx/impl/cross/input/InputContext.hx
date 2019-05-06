package arpx.impl.cross.input;

abstract InputContext(InputContextImpl) from InputContextImpl {
	inline public function new(impl:InputContextImpl) this = impl;

	public var impl(get, never):InputContextImpl;
	inline private function get_impl():InputContextImpl return this;

	private static var _instance:InputContext;
	public static var instance(get, never):InputContext;
	private static function get_instance():InputContext return if (_instance != null) _instance else _instance = createLocal();

#if arp_input_backend_flash
	private static function createLocal():InputContext {
		return new InputContextImpl(flash.Lib.current.stage);
	}
#elseif arp_input_backend_heaps
	private static function createLocal():InputContext {
		return new InputContextImpl();
	}
#elseif arp_input_backend_js
	private static function createLocal():InputContext {
		// TODO this is hardcoded for display backend = heaps, but must be customizable
		return new InputContextImpl(js.Browser.document.getElementById("webgl"));
	}
#elseif arp_input_backend_sys
	private static function createLocal():InputContext {
		return new InputContextImpl();
	}
#elseif arp_input_backend_stub
	private static function createLocal():InputContext {
		return new InputContextImpl();
	}
#end
}
