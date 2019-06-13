package arpx.console;

import arp.domain.IArpObject;
import arp.ds.IOmap;
import arp.task.ITickable;
import arpx.impl.cross.display.RenderContext;
import arpx.input.Input;
import arpx.screen.Screen;
import haxe.ds.ArraySort;

@:arpType("console", "console")
class Console implements IArpObject implements ITickable {
	@:arpField public var width:Int;
	@:arpField public var height:Int;

	@:arpField public var input:Input;
	@:arpField(true) public var screens:IOmap<String, Screen>;

	public function new() return;

	public function tick(timeslice:Float):Bool {
		this.input.tick(timeslice);
		for (screen in this.screens) screen.tick(timeslice);

		var layers:Array<Screen> = [];
		for (screen in this.screens) screen.collectInputLayers(layers);
		ArraySort.sort(layers, (a, b) -> b.priority - a.priority);
		for (layer in layers) {
			if (layer.interact(this.input)) break;
		}
		return true;
	}

	public function render(context:RenderContext):Void {
		for (screen in this.screens) screen.display(context);
	}
}
