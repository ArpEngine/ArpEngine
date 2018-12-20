package arpx;

import arpx.impl.cross.display.RenderContext;

interface IArpEngineEventHandler {
	//** Called once when renderContext is available. domain may not be ready.
	function onStart():Void;

	//** Called every frame after renderContext is available. domain may not be ready.
	function onRawTick(timeslice:Float):Void;

	//** Called once when renderContext and domain is ready.
	function onFirstTick(timeslice:Float):Void;

	//** Called every frame after renderContext and domain is ready.
	function onTick(timeslice:Float):Void;

	//** Rendering is requested from backend. renderContext is ready, but domain may not be ready.
	function onRender(context:RenderContext):Void;
}
