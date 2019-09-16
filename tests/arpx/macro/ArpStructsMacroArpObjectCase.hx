package arpx.macro;

import arp.domain.ArpDomain;
import arp.domain.ArpSlot;
import arp.domain.core.ArpType;
import arp.seed.ArpSeed;
import arp.tests.ArpDomainTestUtil;
import arpx.macro.mocks.MockStructMacroArpObject;
import org.hamcrest.Matchers;
import picotest.PicoAssert.*;

using arp.tests.ArpDomainTestUtil;

class ArpStructsMacroArpObjectCase {

	private var domain:ArpDomain;
	private var slot:ArpSlot<MockStructMacroArpObject>;
	private var arpObj:MockStructMacroArpObject;
	private var xml:Xml;
	private var seed:ArpSeed;

	public function setup():Void {
		domain = new ArpDomain();
		domain.addTemplate(MockStructMacroArpObject, true);
		xml = Xml.parse('
<mock name="name1">
<arpColorField>#ff00ff@7f</arpColorField>
<arpDirectionField>southeast</arpDirectionField>
<arpHitCuboidField>1,2,3,4,5,6</arpHitCuboidField>
<arpPositionField>2,4,6,0</arpPositionField>
<arpRangeField>7..9</arpRangeField>
<arpParamsField>a:b,c:10,d:80000000:idir,faceValue</arpParamsField>
</mock>
		').firstElement();
		seed = ArpSeed.fromXml(xml);
	}

	public function testCreateEmpty():Void {
		arpObj = domain.allocObject(MockStructMacroArpObject);

		assertEquals(domain, arpObj.arpDomain);
		assertEquals(new ArpType("mock"), arpObj.arpType);
		assertNotNull(arpObj.arpColorField);
		assertNotNull(arpObj.arpDirectionField);
		assertNotNull(arpObj.arpHitCuboidField);
		assertNotNull(arpObj.arpParamsField);
		assertNotNull(arpObj.arpPositionField);
		assertNotNull(arpObj.arpRangeField);
	}

	public function testLoadSeed():Void {
		slot = domain.loadSeed(seed, new ArpType("mock"));
		arpObj = slot.value;

		assertEquals(domain, arpObj.arpDomain);
		assertEquals(new ArpType("mock"), arpObj.arpType);
		assertEquals(slot, arpObj.arpSlot);

		assertMatch({color:0x7fff00ff}, arpObj.arpColorField.toHash());
		assertMatch({dir:0x20000000}, arpObj.arpDirectionField.toHash());
		assertMatch({dX:1, dY:2, dZ:3, sizeX:4, sizeY:5, sizeZ:6}, arpObj.arpHitCuboidField.toHash());
		assertMatch(Matchers.containsInAnyOrder("a:b", "c:10", "d:80000000:idir", "face:faceValue"), arpObj.arpParamsField.toHash().params.split(","));
		assertMatch({dir:0, x:2, y:4, z:6}, arpObj.arpPositionField.toHash());
		assertMatch({min:7, max:9}, arpObj.arpRangeField.toHash());
	}

	private function checkIsClone(original:MockStructMacroArpObject, clone:MockStructMacroArpObject):Void {
		assertEquals(original.arpDomain, clone.arpDomain);
		assertEquals(original.arpType, clone.arpType);
		assertNotEquals(original.arpSlot, clone.arpSlot);

		assertMatch(original.arpColorField.toHash(), clone.arpColorField.toHash());
		assertMatch(original.arpDirectionField.toHash(), clone.arpDirectionField.toHash());
		assertMatch(original.arpHitCuboidField.toHash(), clone.arpHitCuboidField.toHash());
		assertMatch(original.arpPositionField.toHash(), clone.arpPositionField.toHash());
		assertMatch(original.arpRangeField.toHash(), clone.arpRangeField.toHash());
	}

	public function testPersistable():Void {
		slot = domain.loadSeed(seed, new ArpType("mock"));
		arpObj = slot.value;

		var clone:MockStructMacroArpObject = ArpDomainTestUtil.roundTrip(domain, arpObj, MockStructMacroArpObject);
		checkIsClone(arpObj, clone);
	}

	public function testArpClone():Void {
		slot = domain.loadSeed(seed, new ArpType("mock"));
		arpObj = slot.value;

		var clone:MockStructMacroArpObject = cast arpObj.arpClone();
		checkIsClone(arpObj, clone);
	}
}
