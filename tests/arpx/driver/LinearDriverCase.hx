package arpx.driver;

import arp.domain.ArpDomain;
import arp.seed.ArpSeed;
import arpx.structs.ArpDirection;
import arpx.mortal.Mortal;

import picotest.PicoAssert.*;

class LinearDriverCase {

	private var domain:ArpDomain;
	private var mortal:Mortal;
	private var me:LinearDriver;

	public function setup() {
		var xml:Xml = Xml.parse('<mortal name="mortal"><driver name="driver" class="linear" /></mortal>').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		domain = new ArpDomain();
		domain.addTemplate(LinearDriver);
		domain.addTemplate(Mortal, true);
		domain.loadSeed(seed);
		mortal = domain.query("mortal", Mortal).value();
		me = domain.query("mortal/driver", LinearDriver).value();
	}


	public function testToward():Void {
		var pos = mortal.position;
		pos.relocate(1, 2, 3);
		pos.dir = ArpDirection.RIGHT;
		assertMatch(1, pos.x);
		assertMatch(2, pos.y);
		assertMatch(3, pos.z);
		assertMatch(0, me.dPos.x);
		assertMatch(0, me.dPos.y);
		assertMatch(0, me.dPos.z);
		assertMatch(0, me.time);
		assertMatch(0, pos.dir.value);
		mortal.toward(2, 2, 4, 6);
		assertMatch(1, pos.x);
		assertMatch(2, pos.y);
		assertMatch(3, pos.z);
		assertMatch(1, me.dPos.x);
		assertMatch(2, me.dPos.y);
		assertMatch(3, me.dPos.z);
		assertMatch(2, me.time);
		//assertTrue(0 != pos.dir.value);
		mortal.toward(2, 1, 2, 3, 3);
		assertMatch(1, pos.x);
		assertMatch(2, pos.y);
		assertMatch(3, pos.z);
		assertMatch(2, me.dPos.x);
		assertMatch(4, me.dPos.y);
		assertMatch(6, me.dPos.z);
		assertMatch(2, me.time);
		//assertTrue(0 != pos.dir.value);
		mortal.towardD(1, 1, 1, 1);
		assertMatch(1, pos.x);
		assertMatch(2, pos.y);
		assertMatch(3, pos.z);
		assertMatch(1, me.dPos.x);
		assertMatch(1, me.dPos.y);
		assertMatch(1, me.dPos.z);
		assertMatch(1, me.time);
		//assertTrue(0 != pos.dir.value);
		mortal.towardD(3, 1, 0, 1, 3);
		assertMatch(1, pos.x);
		assertMatch(2, pos.y);
		assertMatch(3, pos.z);
		assertMatch(3, me.dPos.x);
		assertMatch(0, me.dPos.y);
		assertMatch(3, me.dPos.z);
		assertMatch(3, me.time);
		//assertMatch(0, pos.dir.value);
	}

	public function testTick():Void {
		var pos = mortal.position;
		pos.relocate(0, 0, 0);
		pos.dir = ArpDirection.RIGHT;
		mortal.toward(4, 4, 4, 4);
		assertMatch(0, pos.x);
		me.tick(null, mortal);
		assertMatch(1, pos.x);
		me.tick(null, mortal);
		assertMatch(2, pos.x);
		me.tick(null, mortal);
		assertMatch(3, pos.x);
		me.tick(null, mortal);
		assertMatch(4, pos.x);
		me.tick(null, mortal);
		assertMatch(4, pos.x);
	}
}
