package arpx.screen;

import arp.domain.IArpObject;
import arp.task.ITickable;
import arpx.impl.cross.screen.IScreenImpl;
import arpx.input.focus.IInputLayer;
import arpx.input.Input;

@:arpType("screen", "null")
class Screen implements IArpObject implements ITickable implements IInputLayer<Screen> implements IScreenImpl {
	@:arpField public var ticks:Bool = true;
	@:arpField public var visible:Bool = true;
	@:arpField public var priority:Int = 0;

	@:arpImpl private var arpImpl:IScreenImpl;

	public function new() return;

	public function tick(timeslice:Float):Bool {
		return true;
	}

	public function interact(input:Input):Bool {
		return false;
	}

	public function collectInputLayers(layers:Array<Screen>):Void {
		if (this.visible) layers.push(this);
	}
}
