package arpx.external.decorators;

import arp.data.DataGroup;
import arp.ds.IList;

@:arpType("external", "composite")
class CompositeExternal extends External {

	@:arpBarrier(true, true) @:arpField(true) public var externals:IList<External>;

	public function new() super();

	override public function doLoad(data:DataGroup):Bool {
		var result:Bool = true;
		for (external in externals) if (!external.load(false)) result = false;
		return result;
	}

	override public function doUnload(data:DataGroup):Void for (external in externals) unload();
}
