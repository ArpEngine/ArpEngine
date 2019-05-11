package arpx.impl.cross;

import arpx.impl.cross.input.InputContext;
import arpx.ArpEngineShellBufferMode;
import arpx.impl.cross.display.DisplayContext;
import arpx.impl.cross.display.RenderContext;
import arp.domain.ArpDomain;

class ArpEngineShellBase {

	public var domain(default, null):ArpDomain;

	public var displayContext(get, never):DisplayContext;
	private var _displayContext:DisplayContext;
	public function get_displayContext():DisplayContext {
		if (this._displayContext != null) return this._displayContext;
		return this._displayContext = createDisplayContext();
	}

	public var inputContext(default, null):InputContext;

	private var width:Int;
	private var height:Int;
	private var scaleX:Float = 1.0;
	private var scaleY:Float = 1.0;
	private var bufferMode:ArpEngineShellBufferMode;
	private var clearColor:UInt;

	private dynamic function onStart():Void return;
	private dynamic function onRawTick(timeslice:Float):Void return;
	private dynamic function onFirstTick(timeslice:Float):Void return;
	private dynamic function onTick(timeslice:Float):Void return;
	private dynamic function onRender(context:RenderContext):Void return;


	public function new(domain:ArpDomain, config:ArpEngineConfig) {
		this.domain = domain;

		this.domain.tick.push(this.onDomainFirstTick);

		@:privateAccess @:mergeBlock {
			this.width = config.shellBufferParams.width;
			this.height = config.shellBufferParams.height;
			this.scaleX = config.shellBufferParams.scaleX;
			this.scaleY = config.shellBufferParams.scaleY;
			this.bufferMode = config.shellBufferParams.bufferMode;
			this.clearColor = config.shellBufferParams.clearColor24;
			this.onStart = config.eventParams.onStart;
			this.onRawTick = config.eventParams.onRawTick;
			this.onFirstTick = config.eventParams.onFirstTick;
			this.onTick = config.eventParams.onTick;
			this.onRender = config.eventParams.onRender;
		}

		this.inputContext = InputContext.create(config);
	}

	private function createDisplayContext():DisplayContext return null;

	private function domainRawTick(timeslice:Float):Void {
		this.domain.rawTick.dispatch(timeslice);
		this.onRawTick(timeslice);
	}

	private function doRender(displayContext:DisplayContext):Void {
		var renderContext:RenderContext = displayContext.renderContext();
		this.onRender(renderContext);
		renderContext.display();
	}

	private function onDomainFirstTick(timeslice:Float):Void {
		this.domain.tick.remove(this.onDomainFirstTick);
		this.onFirstTick(timeslice);
		this.domain.tick.push(this.onDomainTick);
	}

	private function onDomainTick(timeslice:Float):Void {
		this.onTick(timeslice);
	}
}
