package arpx.console;

import arp.domain.IArpObject;
import arp.ds.IOmap;
import arp.task.ITickable;
import arpx.impl.cross.display.RenderContext;
import arpx.input.Input;
import arpx.screen.Screen;

@:arpType("console", "console")
class Console implements IArpObject implements ITickable {
	@:arpField public var width:Int;
	@:arpField public var height:Int;

	@:arpField @:arpBarrier public var input:Input;
	@:arpField(true) @:arpBarrier public var screens:IOmap<String, Screen>;

	public function new() return;

	public function tick(timeslice:Float):Bool {
		this.input.tick(timeslice);
		for (screen in this.screens) screen.tick(timeslice);

		var layers:Array<Screen> = [];
		for (screen in this.screens) screen.collectInputLayers(layers);
		var lastPriority:Int = 0x7fffffff;
		while (lastPriority != 0x80000000) {
			var priority:Int = 0x80000000;
			for (layer in layers) {
				var layerPriority:Int = layer.priority;
				if (priority < layerPriority && layerPriority < lastPriority) priority = layerPriority;
			}
			for (layer in layers) {
				if (layer.priority == priority) {
					if (layer.interact(this.input)) return true;
				}
			}
			lastPriority = priority;
		}
		return true;
	}

	public function render(context:RenderContext):Void {
		for (screen in this.screens) screen.display(context);
	}
}
