package arpx.impl.cross.display;

import arpx.structs.ArpColor;
import arpx.impl.cross.texture.TextureFaceData;
import arpx.impl.cross.structs.ArpTransform;

interface IRenderContext {

	var transform(get, never):ArpTransform;

	public function start():Void;
	public function display():Void;

	public function dupTransform():ArpTransform;
	public function popTransform():Void;

	public function fillRect(l:Int, t:Int, w:Int, h:Int, color:UInt):Void;

	public function fillFace(faceData:TextureFaceData, color:ArpColor, hasAlpha:Bool, smoothing:Bool):Void;
}
