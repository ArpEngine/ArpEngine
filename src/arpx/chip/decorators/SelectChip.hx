package arpx.chip.decorators;

import arp.ds.IMap;
import arpx.impl.cross.chip.decorators.SelectChipImpl;
import arpx.impl.cross.geom.RectImpl;
import arpx.structs.IArpParamsRead;

@:arpType("chip", "select")
class SelectChip extends Chip {

	@:arpField(true) @:arpBarrier public var chips:IMap<String, Chip>;
	@:arpField public var selector:String;
	@:arpField public var defaultKey:String = "0";

	@:arpImpl private var arpImpl:SelectChipImpl;

	override public function layoutSize(params:IArpParamsRead, rect:RectImpl):RectImpl return this.select(params).layoutSize(params, rect);

	public function new() super();

	private function select(params:IArpParamsRead = null):Chip {
		if (params == null) return this.chips.get(this.defaultKey);
		return this.chips.get(params.getAsString(this.selector, this.defaultKey));
	}
}
