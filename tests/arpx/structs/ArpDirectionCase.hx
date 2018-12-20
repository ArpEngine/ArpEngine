package arpx.structs;

import arp.testParams.PersistIoProviders.IPersistIoProvider;
import arp.seed.ArpSeed;

import org.hamcrest.Matchers;
import picotest.PicoAssert.*;

class ArpDirectionCase {

	private var provider:IPersistIoProvider;

	@Parameter
	public function setup(provider:IPersistIoProvider):Void {
		this.provider = provider;
	}

	public function testInitWithSeed():Void {
		var ERR:Float = 0.01;
		var dir:ArpDirection = new ArpDirection();
		dir.initWithSeed(ArpSeed.fromXmlString('<dir value="10" />'));
		assertMatch(Matchers.closeTo(10, ERR), dir.valueDegree);
		dir.initWithSeed(ArpSeed.fromXmlString('<dir hoge="20" />').iterator().next());
		assertMatch(Matchers.closeTo(20, ERR), dir.valueDegree);
	}

	public function testClone():Void {
		var dir:ArpDirection = new ArpDirection(50);
		var dir2:ArpDirection = dir.clone();
		assertEquals(dir.value, dir2.value);
	}

	public function testCopyFrom():Void {
		var dir:ArpDirection = new ArpDirection(50);
		var dir2:ArpDirection = new ArpDirection().copyFrom(dir);
		assertEquals(dir.value, dir2.value);
	}

	public function testPersist():Void {
		var dir:ArpDirection = new ArpDirection(50);
		var dir2:ArpDirection = new ArpDirection();
		dir.writeSelf(provider.output);
		dir2.readSelf(provider.input);
		assertEquals(dir.value, dir2.value);
	}
}
