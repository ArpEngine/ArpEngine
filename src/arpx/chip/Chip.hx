package arpx.chip;

import arp.domain.IArpObject;
import arpx.impl.cross.chip.IChipImpl;
import arpx.impl.cross.geom.RectImpl;
import arpx.structs.ArpParams;
import arpx.structs.IArpParamsRead;

@:arpType("chip", "null")
class Chip implements IArpObject implements IChipImpl {

	public function layoutSize(params:IArpParamsRead, rect:RectImpl):RectImpl {
		rect.reset();
		return rect;
	}

	@:noDoc("deprecated")
	private var _workRect:RectImpl = RectImpl.alloc();
	private var _workParams:ArpParams = new ArpParams();

	@:arpImpl private var arpImpl:IChipImpl;

	public function new() return;
}
