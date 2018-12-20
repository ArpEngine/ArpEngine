package arpx.structs;

import arp.testParams.PersistIoProviders.IPersistIoProvider;
import arp.seed.ArpSeed;

import org.hamcrest.Matchers;
import picotest.PicoAssert.*;

class ArpColorCase {

	private var provider:IPersistIoProvider;

	@Parameter
	public function setup(provider:IPersistIoProvider):Void {
		this.provider = provider;
	}

	public function testInitWithSeed():Void {
		var color:ArpColor = new ArpColor();
		color.initWithSeed(ArpSeed.fromXmlString('<color value="#112233@44" />'));
		assertEquals(0x44112233, color.value32);
		color.initWithSeed(ArpSeed.fromXmlString('<color hoge="#556677@88" />').iterator().next());
		assertEquals(0x88556677, color.value32);
	}

	public function testClone():Void {
		var color:ArpColor = new ArpColor(0xccddeeff);
		var color2:ArpColor = color.clone();
		assertEquals(color.value32, color2.value32);
	}

	public function testCopyFrom():Void {
		var color:ArpColor = new ArpColor(0xccddeeff);
		var color2:ArpColor = new ArpColor().copyFrom(color);
		assertEquals(color.value32, color2.value32);
	}

	public function testPersist():Void {
		var color:ArpColor = new ArpColor(0xccddeeff);
		var color2:ArpColor = new ArpColor();
		color.writeSelf(provider.output);
		color2.readSelf(provider.input);
		assertEquals(color.value32, color2.value32);
	}

	public function testGetters():Void {
		var ERR:Float = 0.01;
		var color:ArpColor = new ArpColor(0xcc336699);
		assertMatch(0x33, color.red);
		assertMatch(0x66, color.green);
		assertMatch(0x99, color.blue);
		assertMatch(0xcc, color.alpha);
		assertMatch(Matchers.closeTo(0x33 / 0xff, ERR), color.fred);
		assertMatch(Matchers.closeTo(0x66 / 0xff, ERR), color.fgreen);
		assertMatch(Matchers.closeTo(0x99 / 0xff, ERR), color.fblue);
		assertMatch(Matchers.closeTo(0xcc / 0xff, ERR), color.falpha);
	}

	public function testSetters():Void {
		var ERR:Float = 0.01;
		var color:ArpColor = new ArpColor();
		color.red = 0x33;
		color.green = 0x66;
		color.blue = 0x99;
		color.alpha = 0xcc;
		assertMatch(0x33, color.red);
		assertMatch(0x66, color.green);
		assertMatch(0x99, color.blue);
		assertMatch(0xcc, color.alpha);
		color.value32 = 0;
		color.fred = 0x33 / 0xff;
		color.fgreen = 0x66 / 0xff;
		color.fblue = 0x99 / 0xff;
		color.falpha = 0xcc / 0xff;
		assertMatch(Matchers.closeTo(0x33 / 0xff, ERR), color.fred);
		assertMatch(Matchers.closeTo(0x66 / 0xff, ERR), color.fgreen);
		assertMatch(Matchers.closeTo(0x99 / 0xff, ERR), color.fblue);
		assertMatch(Matchers.closeTo(0xcc / 0xff, ERR), color.falpha);
	}

}
