package arpx.file;

import arp.tests.ArpDomainTestUtil;
import arp.domain.ArpDomain;
import arp.seed.ArpSeed;

import picotest.PicoAssert.*;
import picotest.PicoTestAsync.*;

class LocalFileCase {

	private var domain:ArpDomain;
	private var me:LocalFile;

	public function setup() {
		ArpDomainTestUtil.deployFile("assets/file/localFile.txt");
		var xml:Xml = Xml.parse('<file name="local" heat="warm" src="assets/file/localFile.txt" />').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		domain = new ArpDomain();
		domain.addTemplate(LocalFile, true);
		domain.loadSeed(seed);
		me = domain.obj("local", LocalFile);
	}

	public function testValue() {
		domain.heatLater(me.arpSlot);
		domain.rawTick.dispatch(1);
		assertLater(function():Void {
			assertNotNull(me.bytes());
			assertEquals("localFileValue\n", me.bytes().toString());
		}, 200);
	}
}
