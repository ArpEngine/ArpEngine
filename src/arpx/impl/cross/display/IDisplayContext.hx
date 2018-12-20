package arpx.impl.cross.display;

interface IDisplayContext {
	var width(get, never):Int;
	var height(get, never):Int;
	var clearColor(default, null):UInt;

	function renderContext():RenderContext;
}
