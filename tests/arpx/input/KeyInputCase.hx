package arpx.input;

import arp.domain.ArpDomain;
import arp.seed.ArpSeed;

import picotest.PicoAssert.*;

class KeyInputCase {

	private var domain:ArpDomain;
	private var me:Input;

	public function setup() {
		var xml:Xml = Xml.parse('<input name="input" />').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		domain = new ArpDomain();
		domain.addTemplate(KeyInput, true);
		domain.loadSeed(seed);
		me = domain.obj("input", Input);
	}

#if arp_backend_flash

	public function testTick():Void {
		@:privateAccess {
			me.axis("a").threshold = 0.5;

			assertFalse(me.axis("a").isDown);
			assertFalse(me.axis("a").isTriggerDown);
			assertTrue(me.axis("a").isUp);
			assertTrue(me.axis("a").isTriggerUp);
			assertEquals(0.0, me.axis("a").value);
			assertEquals(0.0, me.axis("a").stateDuration);

			me.axis("a").nextValue = 0.0;
			me.tick(1.0);

			assertFalse(me.axis("a").isDown);
			assertFalse(me.axis("a").isTriggerDown);
			assertTrue(me.axis("a").isUp);
			assertFalse(me.axis("a").isTriggerUp);
			assertEquals(0.0, me.axis("a").value);
			assertEquals(1.0, me.axis("a").stateDuration);

			me.axis("a").nextValue = 0.2;
			me.tick(2.0);

			assertFalse(me.axis("a").isDown);
			assertFalse(me.axis("a").isTriggerDown);
			assertTrue(me.axis("a").isUp);
			assertFalse(me.axis("a").isTriggerUp);
			assertEquals(0.2, me.axis("a").value);
			assertEquals(3.0, me.axis("a").stateDuration);

			me.axis("a").nextValue = 1.0;
			me.tick(1.0);

			assertTrue(me.axis("a").isDown);
			assertTrue(me.axis("a").isTriggerDown);
			assertFalse(me.axis("a").isUp);
			assertFalse(me.axis("a").isTriggerUp);
			assertEquals(1.0, me.axis("a").value);
			assertEquals(0.0, me.axis("a").stateDuration);

			me.axis("a").nextValue = 0.8;
			me.tick(1.0);

			assertTrue(me.axis("a").isDown);
			assertFalse(me.axis("a").isTriggerDown);
			assertFalse(me.axis("a").isUp);
			assertFalse(me.axis("a").isTriggerUp);
			assertEquals(0.8, me.axis("a").value);
			assertEquals(1.0, me.axis("a").stateDuration);

			me.axis("a").nextValue = 0.0;
			me.tick(1.0);

			assertFalse(me.axis("a").isDown);
			assertFalse(me.axis("a").isTriggerDown);
			assertTrue(me.axis("a").isUp);
			assertTrue(me.axis("a").isTriggerUp);
			assertEquals(0.0, me.axis("a").value);
			assertEquals(0.0, me.axis("a").stateDuration);
		}
	}
#end
}
