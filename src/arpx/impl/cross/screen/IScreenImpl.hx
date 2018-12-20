package arpx.impl.cross.screen;

import arp.impl.IArpObjectImpl;
import arpx.impl.cross.display.RenderContext;

interface IScreenImpl extends IArpObjectImpl {
	function display(context:RenderContext):Void;
}
