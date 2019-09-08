package arpx.menu;

import arpx.proc.DynamicProc;
import picotest.PicoAssert;
import arpx.input.InputSource;
import arp.domain.ArpDomain;
import arp.seed.ArpSeed;
import arpx.input.LocalInput;
import arpx.menu.Menu;
import arpx.menuItem.MenuItem;
import arpx.text.FixedTextData;

import picotest.PicoAssert.*;

class MenuCase {

	private var domain:ArpDomain;
	private var me:Menu;
	private var input:LocalInput;

	private var _tmp:Int = -1;
	private var tmp(get, set):Int;
	private function get_tmp():Int {
		var value = _tmp;
		_tmp = -1;
		return value;
	}
	private function set_tmp(value:Int):Int return _tmp = value;

	public function setup() {
		var xml:Xml = Xml.parse('<data>
			<menu name="menu">
				<menuItem>
					<text value="item0" />
				</menuItem>
				<menuItem>
					<text value="item1" />
				</menuItem>
				<menuItem>
					<text value="item2" />
				</menuItem>
				<menuItem>
					<text value="item3" />
				</menuItem>
				<menuItem>
					<text value="item4" />
				</menuItem>
				<menuItem key="key5" shortcut="5" hotkey="7">
					<text value="item5" />
				</menuItem>
				<menuItem shortcut="6" hotkey="6">
					<text value="item6" />
				</menuItem>
				<menuItem>
					<text value="item7" />
				</menuItem>
			</menu>
			<input name="input" />
		</data>').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		domain = new ArpDomain();
		domain.addTemplate(Menu, true);
		domain.addTemplate(MenuItem, true);
		domain.addTemplate(FixedTextData, true);
		domain.addTemplate(LocalInput, true);
		domain.loadSeed(seed);
		me = domain.obj("menu", Menu);
		input = domain.obj("input", LocalInput);
		input.bindKeyAxis(1, "axis", 1);
		input.bindKeyAxis(2, "axis", -1);
		input.bindKeyAxis(3, "execute", 1);
		input.bindKeyAxis(4, "abort", 1);
		input.bindKeyAxis(5, "5", 1);
		input.bindKeyAxis(6, "6", 1);
		input.bindKeyAxis(7, "7", 1);

		for (i in 0...me.menuItems.length) {
			var proc:DynamicProc = domain.allocObject(DynamicProc);
			var f:()->(()->Void) = () -> { () -> { tmp = i; }};
			proc.onExecute = f();
			me.menuItems.getAt(i).proc = proc;
		}
	}

	public function testItem():Void {
		PicoAssert.assertEquals("item0", me.selection.text.publish(null));
		me.value = 3;
		PicoAssert.assertEquals("item3", me.selection.text.publish(null));
	}

	public function testResolveKeyIndex():Void {
		PicoAssert.assertEquals(-1, me.resolveKeyIndex("null"));
		PicoAssert.assertEquals(5, me.resolveKeyIndex("key5"));
	}

	public function testResolveShortcutIndex():Void {
		PicoAssert.assertEquals(-1, me.resolveShortcutIndex("null"));
		PicoAssert.assertEquals(5, me.resolveShortcutIndex("5"));
		PicoAssert.assertEquals(6, me.resolveShortcutIndex("6"));
	}

	public function testResolveHotkeyIndex():Void {
		PicoAssert.assertEquals(-1, me.resolveHotkeyIndex("null"));
		PicoAssert.assertEquals(5, me.resolveHotkeyIndex("7"));
		PicoAssert.assertEquals(6, me.resolveHotkeyIndex("6"));
	}

	public function testInteractWith():Void {
		PicoAssert.assertEquals(0, me.value);
		PicoAssert.assertEquals(-1, tmp);

		me.interactWith(input, new MockAxes());
		PicoAssert.assertEquals(0, me.value);
		PicoAssert.assertEquals(-1, tmp);

		input.setState(InputSource.Key(1));
		input.tick(1.0);
		assertEquals(1.0, input.axis("axis").value);
		me.interactWith(input, new MockAxes());
		PicoAssert.assertEquals(1, me.value);
		PicoAssert.assertEquals(-1, tmp);

		input.clearStates();
		input.tick(1.0);

		input.setState(InputSource.Key(2));
		input.tick(1.0);
		me.interactWith(input, new MockAxes());
		PicoAssert.assertEquals(0, me.value);
		PicoAssert.assertEquals(-1, tmp);

		input.clearStates();
		input.tick(1.0);

		input.setState(InputSource.Key(3));
		input.tick(1.0);
		me.interactWith(input, new MockAxes());
		PicoAssert.assertEquals(0, me.value);
		PicoAssert.assertEquals(0, tmp);

		input.clearStates();
		input.tick(1.0);

		input.setState(InputSource.Key(5));
		input.tick(1.0);
		me.interactWith(input, new MockAxes());
		PicoAssert.assertEquals(5, me.value);
		PicoAssert.assertEquals(-1, tmp);

		input.clearStates();
		input.tick(1.0);

		input.setState(InputSource.Key(6));
		input.tick(1.0);
		me.interactWith(input, new MockAxes());
		PicoAssert.assertEquals(6, me.value);
		PicoAssert.assertEquals(-1, tmp);

		input.clearStates();
		input.tick(1.0);

		input.setState(InputSource.Key(6));
		input.tick(1.0);
		me.interactWith(input, new MockAxes());
		PicoAssert.assertEquals(6, me.value);
		PicoAssert.assertEquals(6, tmp);

		input.clearStates();
		input.tick(1.0);

		input.setState(InputSource.Key(7));
		input.tick(1.0);
		me.interactWith(input, new MockAxes());
		PicoAssert.assertEquals(6, me.value);
		PicoAssert.assertEquals(5, tmp);
	}
}

private class MockAxes implements IMenuAxes {
	public var axis(get, set):String;
	public var execute(get, set):String;
	public var abort(get, set):String;

	public function new() return;

	function get_axis():String return "axis";
	function set_axis(value:String):String return "axis";

	function get_execute():String return "execute";
	function set_execute(value:String):String return "execute";

	function get_abort():String return "abort";
	function set_abort(value:String):String return "abort";
}
