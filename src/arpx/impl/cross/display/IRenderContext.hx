package arpx.impl.cross.display;

import arpx.impl.cross.display.stack.ArpColorStack;
import arpx.structs.ArpColor;
import arpx.impl.cross.structs.ArpTransform;
import arpx.impl.cross.texture.TextureFaceData;

interface IRenderContext {

	var transform(get, never):ArpTransform;

	function start():Void;
	function display():Void;

	function dupTransform():ArpTransform;
	function popTransform():Void;

	var tint(get, never):ArpColor;
	var tints(get, never):ArpColorStack;
	function colors(key:String):ArpColorStack;

	function fillRect(l:Int, t:Int, w:Int, h:Int):Void;

	function fillFace(faceData:TextureFaceData, hasAlpha:Bool, smoothing:Bool):Void;
}
