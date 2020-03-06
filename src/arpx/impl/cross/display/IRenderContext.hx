package arpx.impl.cross.display;

import arpx.impl.cross.structs.ArpTransform;
import arpx.impl.cross.texture.TextureFaceData;
import arpx.structs.ArpColor;

interface IRenderContext {

	var transform(get, never):ArpTransform;

	public function start():Void;
	public function display():Void;

	public function dupTransform():ArpTransform;
	public function popTransform():Void;

	public function fillRect(l:Int, t:Int, w:Int, h:Int, color:ArpColor):Void;

	public function fillFace(faceData:TextureFaceData, color:ArpColor, hasAlpha:Bool, smoothing:Bool):Void;
}
