package arpx.structs;

import arp.testParams.PersistIoProviders.IPersistIoProvider;
import arp.seed.ArpSeed;
import arpx.structs.ArpParams;
import arpx.structs.params.ArpParamsProxy;

import org.hamcrest.Matchers;
import picotest.PicoAssert.*;

class ArpParamsCase {

	private var provider:IPersistIoProvider;

	@Parameter
	public function setup(provider:IPersistIoProvider):Void {
		this.provider = provider;
	}

	public function testAddParam():Void {
		var params:ArpParamsProxy = new ArpParams();
		params["a"] = "b";
		params["c"] = 10;
		params["d"] = ArpDirection.LEFT;
		params.set("e", "f");
		assertEquals("b", params["a"]);
		assertEquals(10, params["c"]);
		assertEquals(ArpDirection.LEFT.value, params["d"].value);
		assertEquals("f", params["e"]);
	}

	public function testToString():Void {
		var params:ArpParamsProxy = new ArpParams();
		assertEquals("", Std.string(params));
		params["a"] = "b";
		assertMatch(["a:b"], Std.string(params).split(","));
		params["c"] = 10;
		assertMatch(Matchers.containsInAnyOrder("a:b", "c:10"), Std.string(params).split(","));
		params["d"] = ArpDirection.LEFT;
		assertMatch(Matchers.containsInAnyOrder("a:b", "c:10", "d:80000000:idir"), Std.string(params).split(","));
	}

	public function initWithSeedTest():Void {
		var params:ArpParamsProxy = new ArpParams();
		params.initWithSeed(ArpSeed.fromXmlString("<params>a:b,c:10,d:80000000:idir,faceValue</params>"));
		assertEquals("b", params["a"]);
		assertEquals(10, params["c"]);
		assertEquals(ArpDirection.LEFT.value, params["d"].value);
		assertEquals("faceValue", params["face"]);
	}

	public function testClone():Void {
		var params:ArpParamsProxy = new ArpParams();
		params["a"] = "b";
		params["c"] = 10;
		params["d"] = ArpDirection.LEFT;
		var params2:ArpParamsProxy = params.clone();
		assertEquals(params["a"], params2["a"]);
		assertEquals(params["c"], params2["c"]);
		assertEquals(params["d"].value, params2["d"].value);
	}

	public function testCopyFrom():Void {
		var params:ArpParamsProxy = new ArpParams();
		params["a"] = "b";
		params["c"] = 10;
		params["d"] = ArpDirection.LEFT;
		var params2:ArpParamsProxy = new ArpParams().copyFrom(params);
		assertEquals(params["a"], params2["a"]);
		assertEquals(params["c"], params2["c"]);
		assertEquals(params["d"].value, params2["d"].value);
	}

	public function testPersist():Void {
		var params:ArpParamsProxy = new ArpParams();
		params["a"] = "b";
		params["c"] = 10;
		params["d"] = ArpDirection.LEFT;
		var params2:ArpParamsProxy = new ArpParams();
		params.writeSelf(provider.output);
		params2.readSelf(provider.input);
		assertEquals(params["a"], params2["a"]);
		assertEquals(params["c"], params2["c"]);
		assertEquals(params["d"].value, params2["d"].value);
	}

	public function testFromAnon():Void {
		var params:ArpParamsProxy = ArpParams.fromAnon({a: "b", c: 10, d: ArpDirection.LEFT});
		assertEquals("b", params["a"]);
		assertEquals(10, params["c"]);
		assertEquals(ArpDirection.LEFT.value, params["d"].value);
	}

	public function testGetSafe():Void {
		var params:ArpParamsProxy = new ArpParams();
		params["null"] = null;
		params["str"] = "aaaa";
		params["int"] = 10;

		assertEquals(null, params.getString("null"));
		assertEquals("aaaa", params.getString("str"));
		assertThrows(function() params.getString("int"), e -> assertEquals("Wrong type in ArpParams", e));

		assertEquals("default", params.getString("null", "default"));
		assertEquals("aaaa", params.getString("str", "default"));
		assertThrows(function() params.getString("int"), e -> assertEquals("Wrong type in ArpParams", e));

		assertEquals(null, params.getInt("null"));
		assertEquals(10, params.getInt("int"));
		assertThrows(function() params.getInt("str"), e -> assertEquals("Wrong type in ArpParams", e));

		assertEquals(30, params.getInt("null", 30));
		assertEquals(10, params.getInt("int", 30));
		assertThrows(function() params.getInt("str"), e -> assertEquals("Wrong type in ArpParams", e));

		assertEquals(null, params.getAsString("null"));
		assertEquals("aaaa", params.getAsString("str"));
		assertEquals("10", params.getAsString("int"));
	}
}


