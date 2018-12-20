package arpx.impl.cross.mortal;

import arp.impl.IArpObjectImpl;
import arpx.impl.cross.display.RenderContext;

interface IMortalImpl extends IArpObjectImpl {
	function render(context:RenderContext):Void;
}
