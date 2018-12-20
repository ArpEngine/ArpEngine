package arpx.structs;

import arp.testParams.PersistIoProviders.IPersistIoProvider;
import arp.seed.ArpSeed;
import picotest.PicoAssert.*;

class ArpRangeCase {

	private var provider:IPersistIoProvider;

	@Parameter
	public function setup(provider:IPersistIoProvider):Void {
		this.provider = provider;
	}

	public function testGetRange():Void {
		assertMatch(0, new ArpRange(20, 20).range);
		assertMatch(10, new ArpRange(10, 20).range);
		assertMatch(20, new ArpRange(0, 20).range);
		assertMatch(30, new ArpRange(-10, 20).range);
		assertMatch(Math.NaN, new ArpRange(-10, Math.NaN).range);
	}

	public function testSetRange():Void {
		var range:ArpRange = new ArpRange(10, 20);
		range.range = 20;
		assertMatch(30, range.maxValue);
	}

	public function testInitWithSeed():Void {
		var range:ArpRange = new ArpRange();
		range.initWithSeed(ArpSeed.fromXmlString('<range min="10" max="20" />'));
		assertMatch(10, range.minValue);
		assertMatch(20, range.maxValue);
		range.initWithSeed(ArpSeed.fromXmlString('<range hoge="30..40" />').iterator().next());
		assertMatch(30, range.minValue);
		assertMatch(40, range.maxValue);
	}

	public function testClone():Void {
		var range:ArpRange = new ArpRange(30, 50);
		var range2:ArpRange = range.clone();
		assertMatch(range.minValue, range2.minValue);
		assertMatch(range.maxValue, range2.maxValue);
	}

	public function testCopyFrom():Void {
		var range:ArpRange = new ArpRange(30, 50);
		var range2:ArpRange = new ArpRange().copyFrom(range);
		assertMatch(range.minValue, range2.minValue);
		assertMatch(range.maxValue, range2.maxValue);
	}

	public function testHasValue():Void {
		assertTrue(new ArpRange(0, 0).hasValue);
		assertFalse(new ArpRange(10, 0).hasValue);
		assertTrue(new ArpRange(0, 10).hasValue);
		assertFalse(new ArpRange(0, Math.NaN).hasValue);
	}

	public function testContains():Void {
		var range:ArpRange = new ArpRange(50, 100);
		assertFalse(range.contains(49));
		assertTrue(range.contains(50));
		assertTrue(range.contains(75));
		assertTrue(range.contains(100));
		assertFalse(range.contains(101));
	}

	public function testNormalize():Void {
		var range:ArpRange = new ArpRange(50, 100);
		assertMatch(50, range.normalize(0));
		assertMatch(60, range.normalize(10));
		assertMatch(90, range.normalize(40));
		assertMatch(50, range.normalize(50));
		assertMatch(60, range.normalize(60));
		assertMatch(90, range.normalize(90));
		assertMatch(100, range.normalize(100));
		assertMatch(60, range.normalize(110));
		assertMatch(90, range.normalize(140));
		assertMatch(100, range.normalize(150));
	}

	public function testToArray():Void {
		assertMatch([3, 4, 5, 6, 7], new ArpRange(3, 7).toArray());
	}

	public function testSplit():Void {
		assertMatch(["3", "4", "5", "6", "7"], new ArpRange(3, 7).split());
	}

	public function testRandom():Void {
		var range:ArpRange = new ArpRange(0, 4);
		for (i in 0...1000) {
			var random:Float = range.random();
			assertTrue(random >= 0 && random < 4);
			var randomInt:Int = range.randomInt();
			assertTrue(random >= 0 && random <= 4);
		}
	}

	public function testPersist():Void {
		var range:ArpRange = new ArpRange(30, 50);
		var range2:ArpRange = new ArpRange();
		range.writeSelf(provider.output);
		range2.readSelf(provider.input);
		assertEquals(range.minValue, range2.minValue);
		assertEquals(range.maxValue, range2.maxValue);
	}

}
