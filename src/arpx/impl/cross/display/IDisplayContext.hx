package arpx.impl.cross.display;

import arpx.structs.ArpColor;

interface IDisplayContext {
	var width(get, never):Int;
	var height(get, never):Int;
	var clearColor(default, null):ArpColor;

	function renderContext():RenderContext;
}
