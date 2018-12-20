package arpx.impl.cross.chip;

import arp.impl.IArpObjectImpl;
import arpx.impl.cross.display.RenderContext;
import arpx.structs.IArpParamsRead;

interface IChipImpl extends IArpObjectImpl {
	function render(context:RenderContext, params:IArpParamsRead = null):Void;
}
