package arpx.impl.cross.input;

import arpx.impl.cross.structs.ArpTransform;
import arpx.impl.cross.geom.PointImpl;

class InputContext {

	public var impl(default, null):InputContextImpl;
	private var transform:ArpTransform;

	public function new(config:ArpEngineConfig, impl:InputContextImpl) {
		this.impl = impl;
		var scaleX:Float = @:privateAccess config.shellBufferParams.scaleX;
		var scaleY:Float = @:privateAccess config.shellBufferParams.scaleY;
		this.transform = new ArpTransform().reset(scaleX, 0, 0, scaleY, 0, 0).invert();
	}

	private var _workPt:PointImpl = PointImpl.alloc();
	public function rawToWorld(x:Float, y:Float):PointImpl {
		var pt:PointImpl = _workPt;
		pt.reset(x, y);
		this.transform.transformPoint(pt);
		return pt;
	}

	public static function create(config:ArpEngineConfig):InputContext {
		return new InputContext(config, createImpl(config));
	}

#if arp_input_backend_flash
	private static function createImpl(config:ArpEngineConfig):InputContextImpl {
		return new InputContextImpl(flash.Lib.current.stage);
	}
#elseif arp_input_backend_heaps
	private static function createImpl(config:ArpEngineConfig):InputContextImpl {
		return new InputContextImpl();
	}
#elseif arp_input_backend_js
	private static function createImpl(config:ArpEngineConfig):InputContextImpl {
		// TODO this is hardcoded for display backend = heaps, but must be customizable
		return new InputContextImpl(js.Browser.document.getElementById("webgl"));
	}
#elseif arp_input_backend_sys
	private static function createImpl(config:ArpEngineConfig):InputContextImpl {
		return new InputContextImpl();
	}
#elseif arp_input_backend_stub
	private static function createImpl(config:ArpEngineConfig):InputContextImpl {
		return new InputContextImpl();
	}
#end
}
