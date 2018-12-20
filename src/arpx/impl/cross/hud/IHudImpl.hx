package arpx.impl.cross.hud;

import arp.impl.IArpObjectImpl;
import arpx.impl.cross.display.RenderContext;

interface IHudImpl extends IArpObjectImpl {
	function render(context:RenderContext):Void;
}
