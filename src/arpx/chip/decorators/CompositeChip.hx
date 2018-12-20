package arpx.chip.decorators;

import arp.ds.IList;
import arpx.impl.cross.chip.decorators.CompositeChipImpl;
import arpx.impl.cross.geom.RectImpl;
import arpx.structs.IArpParamsRead;

@:arpType("chip", "composite")
class CompositeChip extends Chip {

	@:arpField(true) @:arpBarrier public var chips:IList<Chip>;

	@:arpImpl private var arpImpl:CompositeChipImpl;

	override public function layoutSize(params:IArpParamsRead, rect:RectImpl):RectImpl return chips.first().layoutSize(params, rect);

	public function new() super();
}
