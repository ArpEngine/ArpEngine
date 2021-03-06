package arpx.screen;

import arp.ds.IOmap;
import arp.task.Heartbeat;
import arpx.impl.cross.screen.CompositeScreenImpl;

@:arpType("screen", "composite")
class CompositeScreen extends Screen {
	@:arpBarrier @:arpField(true) public var screens:IOmap<String, Screen>;

	@:arpImpl private var arpImpl:CompositeScreenImpl;

	public function new() super();

	override public function tick(timeslice:Float):Heartbeat {
		for (screen in this.screens) screen.tick(timeslice);
		return Heartbeat.Keep;
	}

	override public function collectInputLayers(layers:Array<Screen>):Void {
		if (!this.visible) return;
		if (this.priority == 0) {
			for (screen in this.screens) screen.collectInputLayers(layers);
		} else {
			layers.push(this);
		}
	}
}
