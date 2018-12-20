package arpx.console;

import arp.domain.IArpObject;
import arp.ds.IOmap;
import arp.task.ITickable;
import arpx.impl.cross.display.RenderContext;
import arpx.input.focus.IFocusNode;
import arpx.input.Input;
import arpx.screen.Screen;

@:arpType("console", "console")
class Console implements IArpObject implements ITickable implements IFocusNode<Input> {
	@:arpField public var width:Int;
	@:arpField public var height:Int;

	@:arpField(true) public var screens:IOmap<String, Screen>;

	public function new() return;

	public function tick(timeslice:Float):Bool {
		for (screen in this.screens) screen.tick(timeslice);
		this.updateFocus(this.findFocus(null));
		return true;
	}

	public function findFocus(other:Null<Input>):Null<Input> {
		for (screen in this.screens) other = screen.findFocus(other);
		return other;
	}

	public function updateFocus(target:Null<Input>):Void {
		for (screen in this.screens) screen.updateFocus(target);
	}

	public function render(context:RenderContext):Void {
		for (screen in this.screens) screen.display(context);
	}
}
