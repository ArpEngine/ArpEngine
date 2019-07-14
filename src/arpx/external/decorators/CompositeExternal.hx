package arpx.external.decorators;

import arp.ds.IList;

@:arpType("external", "composite")
class CompositeExternal extends External {

	@:arpBarrier(true, true) @:arpField(true) public var externals:IList<External>;

	public function new() super();

	override public function load(force:Bool = false):Void for (external in externals) load(force);
	override public function unload():Void for (external in externals) unload();
}
