package arpx.impl.cross.field;

import arp.impl.IArpObjectImpl;
import arpx.impl.cross.display.RenderContext;

interface IFieldImpl extends IArpObjectImpl {
	function render(context:RenderContext):Void;
}

