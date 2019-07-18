package arpx.menu;

import arp.domain.IArpObject;
import arp.ds.IOmap;
import arpx.menuItem.MenuItem;

@:arpType("menu")
class Menu implements IArpObject {
	@:arpField public var visible:Bool = true;
	@:arpField(true) public var menuItems:IOmap<String, MenuItem>;

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
}


