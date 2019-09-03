package arpx.menu;

import arp.domain.IArpObject;
import arp.ds.IOmap;
import arpx.input.Input;
import arpx.inputAxis.InputAxis;
import arpx.menuItem.MenuItem;
import arpx.proc.Proc;

@:arpType("menu")
class Menu implements IArpObject {
	@:arpField public var visible:Bool = true;
	@:arpField(true) public var menuItems:IOmap<String, MenuItem>;

	@:arpField public var abort:Proc;

	@:arpField public var value:Int;

	public var length(get, never):Int;
	inline private function get_length():Int return this.menuItems.length;

	public var selection(get, never):Null<MenuItem>;
	inline private function get_selection():Null<MenuItem> {
		var item:MenuItem = this.menuItems.getAt(this.value);
		return if (item != null) item else null;
	}

	public function new() return;

	public function shift(delta:Int):Int {
		var value:Int = this.value + delta;
		if (value < 0) value = 0;
		var length:Int = this.menuItems.length;
		if (value >= length) value = length - 1;
		return this.value = value;
	}

	public function execute(value:Int):Bool {
		var item:MenuItem = this.menuItems.getAt(value);
		if (item == null || item.proc == null) return false;
		item.proc.execute();
		return true;
	}

	inline public function executeSelection():Bool {
		return execute(this.value);
	}

	inline public function executeAbort():Bool {
		if (this.abort == null) return false;
		this.abort.execute();
		return true;
	}

	public function interactWith(input:Input, axes:IMenuAxes):Bool {
		var axis:InputAxis = input.axis(axes.axis);
		if (axis.isTrigger) {
			if (axis.value > 0) {
				this.shift(1);
			} else if (axis.value < 0) {
				this.shift(-1);
			}
		}
		var execute:InputAxis = input.axis(axes.execute);
		if (execute.isTriggerDown) {
			this.executeSelection();
		}
		if (axes.abort != null) {
			var abort:InputAxis = input.axis(axes.abort);
			if (abort.isTriggerDown) {
				this.executeAbort();
			}
		}
		return true;
	}
}


