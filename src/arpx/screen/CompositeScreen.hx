package arpx.screen;

import arp.ds.IOmap;
import arpx.impl.cross.screen.CompositeScreenImpl;

@:arpType("screen", "composite")
class CompositeScreen extends Screen {
	@:arpBarrier @:arpField(true) public var screens:IOmap<String, Screen>;

	@:arpImpl private var arpImpl:CompositeScreenImpl;

	public function new() super();

	override public function tick(timeslice:Float):Bool {
		for (screen in this.screens) screen.tick(timeslice);
		return true;
	}

	override public function findFocus(other:Null<Screen>):Null<Screen> {
		for (screen in this.screens) other = screen.findFocus(other);
		return other;
	}
}
