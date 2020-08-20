package arpx.text;

import arp.domain.core.ArpType;
import arp.domain.ArpDomain;
import arp.seed.ArpSeed;
import arpx.structs.ArpParams;

import picotest.PicoAssert.*;

class TextDataCase {

	private var domain:ArpDomain;
	private var me:FixedTextData;

	public function setup() {
		var xml:Xml = Xml.parse('<data>
		<text class="text" name="name1" value="{foo}{bar}" />
		</data>
		').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		domain = new ArpDomain();
		domain.addTemplate(FixedTextData);
		domain.addTemplate(ParametrizedTextData);
		domain.loadSeed(seed);
		me = domain.query("name1", new ArpType("text")).value();
	}

	public function testFields() {
		assertEquals("{foo}{bar}", me.value);
	}

	public function testPublishNull() {
		assertEquals("{foo}{bar}", me.publish(null));
	}

	public function testPublishAnon() {
		assertEquals("{foo}{bar}", me.publishAnon({foo: "hoge", bar: "fuga"}));
	}

	public function testComplexPublish() {
		var params:ArpParams = new ArpParams();
		params.set("foo", "hoge");
		params.set("bar", "fuga");
		assertEquals("{foo}{bar}", me.publish(params));
	}
}
