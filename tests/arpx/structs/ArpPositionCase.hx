package arpx.structs;

import arp.testParams.PersistIoProviders.IPersistIoProvider;
import arp.seed.ArpSeed;

import org.hamcrest.Matchers;
import picotest.PicoAssert.*;

class ArpPositionCase {

	private var provider:IPersistIoProvider;

	@Parameter
	public function setup(provider:IPersistIoProvider):Void {
		this.provider = provider;
	}

	public function testInitWithSeed():Void {
		var ERR:Float = 0.01;
		var pos:ArpPosition = new ArpPosition();
		pos.initWithSeed(ArpSeed.fromXmlString('<pos x="1" y="2" z="3" dir="4" />'));
		assertMatch(1, pos.x);
		assertMatch(2, pos.y);
		assertMatch(3, pos.z);
		assertMatch(Matchers.closeTo(4, ERR), pos.dir.valueDegree);
		var pos:ArpPosition = new ArpPosition();
		pos.initWithSeed(ArpSeed.fromXmlString('<pos x="1g" y="2g" z="3g" dir="4" />'));
		assertMatch(1, pos.x);
		assertMatch(2, pos.y);
		assertMatch(3, pos.z);
		assertMatch(Matchers.closeTo(4, ERR), pos.dir.valueDegree);
		var pos:ArpPosition = new ArpPosition();
		pos.initWithSeed(ArpSeed.fromXmlString('<pos hoge="5,6,7,8" />').iterator().next());
		assertMatch(5, pos.x);
		assertMatch(6, pos.y);
		assertMatch(7, pos.z);
		assertMatch(Matchers.closeTo(8, ERR), pos.dir.valueDegree);
		var pos:ArpPosition = new ArpPosition();
		pos.initWithSeed(ArpSeed.fromXmlString('<pos hoge="5g,6g,7g,8" />').iterator().next());
		assertMatch(5, pos.x);
		assertMatch(6, pos.y);
		assertMatch(7, pos.z);
		assertMatch(Matchers.closeTo(8, ERR), pos.dir.valueDegree);
		var pos:ArpPosition = new ArpPosition();
		pos.initWithSeed(ArpSeed.fromXmlString('<pos hoge="" />').iterator().next());
		assertMatch(0, pos.x);
		assertMatch(0, pos.y);
		assertMatch(0, pos.z);
		assertMatch(Matchers.closeTo(0, ERR), pos.dir.valueDegree);
	}

	public function testRelocate():Void {
		var pos:ArpPosition = new ArpPosition(1, 2, 3, 0);
		assertMatch(1, pos.x);
		assertMatch(2, pos.y);
		assertMatch(3, pos.z);
		assertMatch(0, pos.dir.value);
		pos.relocate(2, 4, 6);
		assertMatch(2, pos.x);
		assertMatch(4, pos.y);
		assertMatch(6, pos.z);
		assertMatch(0, pos.dir.value);
		pos.relocate(1, 2, 3, 3);
		assertMatch(3, pos.x);
		assertMatch(6, pos.y);
		assertMatch(9, pos.z);
		assertMatch(0, pos.dir.value);
		pos.relocateD(1, 1, 1);
		assertMatch(4, pos.x);
		assertMatch(7, pos.y);
		assertMatch(10, pos.z);
		assertMatch(0, pos.dir.value);
		pos.relocateD(-1, -1, -1);
		pos.relocateD(1, 1, 1, 3);
		assertMatch(6, pos.x);
		assertMatch(9, pos.y);
		assertMatch(12, pos.z);
		assertMatch(0, pos.dir.value);
	}

	public function testClone():Void {
		var pos:ArpPosition = new ArpPosition(1, 2, 3, 4);
		var pos2:ArpPosition = pos.clone();
		assertMatch(pos.x, pos2.x);
		assertMatch(pos.y, pos2.y);
		assertMatch(pos.z, pos2.z);
		assertMatch(pos.dir.value, pos2.dir.value);
	}

	public function testCopyFrom():Void {
		var pos:ArpPosition = new ArpPosition(1, 2, 3, 4);
		var pos2:ArpPosition = new ArpPosition().copyFrom(pos);
		assertMatch(pos.x, pos2.x);
		assertMatch(pos.y, pos2.y);
		assertMatch(pos.z, pos2.z);
		assertMatch(pos.dir.value, pos2.dir.value);
	}

	public function testPersist():Void {
		var pos:ArpPosition = new ArpPosition(1, 2, 3, 4);
		var pos2:ArpPosition = new ArpPosition();
		pos.writeSelf(provider.output);
		pos2.readSelf(provider.input);
		assertMatch(pos.x, pos2.x);
		assertMatch(pos.y, pos2.y);
		assertMatch(pos.z, pos2.z);
		assertMatch(pos.dir.value, pos2.dir.value);
	}
}
