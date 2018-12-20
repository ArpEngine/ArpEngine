package arpx;

import arpx.impl.cross.display.RenderContext;
import arpx.ArpEngineShellBufferMode;

class ArpEngineConfig {

	private var shellBufferParams(default, null):ArpEngineShellBufferParams;
	private var eventParams(default, null):ArpEngineEventParams;

	public function new() {
		this.shellBufferParams = new ArpEngineShellBufferParams();
		this.eventParams = new ArpEngineEventParams();
	}

	public function shellBuffer(width:Int, height:Int, clearColor:UInt = 0xff000000):ArpEngineConfig {
		this.shellBufferParams.width = width;
		this.shellBufferParams.height = height;
		this.shellBufferParams.clearColor = clearColor;
		return this;
	}

	public function shellBufferScaling(scaleX:Float, scaleY:Null<Float> = null, bufferMode:Null<ArpEngineShellBufferMode> = null):ArpEngineConfig {
		this.shellBufferParams.scaleX = scaleX;
		this.shellBufferParams.scaleY = if (scaleY == null) scaleX else scaleY;
		this.shellBufferParams.bufferMode = if (bufferMode == null) ArpEngineShellBufferMode.Automatic else bufferMode;
		return this;
	}

	public function start(start:Void->Void):ArpEngineConfig {
		this.eventParams.onStart = start;
		return this;
	}

	public function rawTick(rawTick:Float->Void):ArpEngineConfig {
		this.eventParams.onRawTick = rawTick;
		return this;
	}

	public function firstTick(firstTick:Float->Void):ArpEngineConfig {
		this.eventParams.onFirstTick = firstTick;
		return this;
	}

	public function tick(tick:Float->Void):ArpEngineConfig {
		this.eventParams.onTick = tick;
		return this;
	}

	public function render(render:RenderContext->Void):ArpEngineConfig {
		this.eventParams.onRender = render;
		return this;
	}

	public function events(handler:IArpEngineEventHandler):ArpEngineConfig {
		this.eventParams.onStart = handler.onStart;
		this.eventParams.onRawTick = handler.onRawTick;
		this.eventParams.onFirstTick = handler.onFirstTick;
		this.eventParams.onTick = handler.onTick;
		this.eventParams.onRender = handler.onRender;
		return this;
	}
}

class ArpEngineShellBufferParams {
	public var width:Int = 640;
	public var height:Int = 480;
	public var clearColor:UInt = 0xff000000;
	public var scaleX:Float = 1.0;
	public var scaleY:Float = 1.0;
	public var bufferMode:ArpEngineShellBufferMode = ArpEngineShellBufferMode.Automatic;

	public var clearColor24(get, never):UInt;
	private function get_clearColor24():UInt return clearColor | 0xff000000;

	public function new() return;
}

class ArpEngineEventParams {
	public dynamic function onStart():Void return;
	public dynamic function onRawTick(timeslice:Float):Void return;
	public dynamic function onFirstTick(timeslice:Float):Void return;
	public dynamic function onTick(timeslice:Float):Void return;
	public dynamic function onRender(context:RenderContext):Void return;
	public function new() return;
}
