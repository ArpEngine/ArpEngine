package arpx.impl.cross.structs;

import arp.testParams.PersistIoProviders.IPersistIoProvider;
import arp.seed.ArpSeed;
import picotest.PicoAssert.*;

class ArpTransformCase {

	private var provider:IPersistIoProvider;

	var me:ArpTransform;

	private var data(get, never):Array<Float>;
	private function get_data():Array<Float> return me.toData();

	private var newMe(get, never):ArpTransform;
	private function get_newMe():ArpTransform return new ArpTransform().reset(1.0, 0.0, 0.0, 2.0, 300.0, 400.0);

	@Parameter
	public function setup(provider:IPersistIoProvider):Void {
		me = newMe;
		this.provider = provider;
	}

	public function testInitWithSeed():Void {
		me.initWithSeed(ArpSeed.fromXmlString('<transform value="1,2,3,4,5,6" />'));
		assertMatch([1, 2, 3, 4, 5, 6], me.toData());
		me.initWithSeed(ArpSeed.fromXmlString('<transform hoge="7,8;9,10;11,12" />').iterator().next());
		assertMatch([7, 8, 9, 10, 11, 12], me.toData());
		me.initWithSeed(ArpSeed.fromXmlString('<transform a="1" b="2" c="3" d="4" x="5" y="6" />'));
		assertMatch([1, 2, 3, 4, 5, 6], me.toData());
		me.initWithSeed(ArpSeed.fromXmlString('<transform xx="7" yx="8" xy="9" yy="10" tx="11" ty="12" />'));
		assertMatch([7, 8, 9, 10, 11, 12], me.toData());
	}

	public function testPersist():Void {
		me.writeSelf(provider.output);
		var other:ArpTransform = new ArpTransform();
		other.readSelf(provider.input);
		assertMatch(me.toData(), other.toData());
	}

	public function testReset() {
		me.reset(20.0, 0.0, 1.0, 30.0, 50.0, 100.0);
		assertMatch([20.0, 0.0, 1.0, 30.0, 50.0, 100.0], data);
	}

	public function testReadData() {
		me.readData([20.0, 0.0, 1.0, 30.0, 50.0, 100.0]);
		assertMatch([20.0, 0.0, 1.0, 30.0, 50.0, 100.0], data);
	}

	public function testToData() {
		var data:Array<Float> = me.toData();
		assertMatch([1.0, 0.0, 0.0, 2.0, 300.0, 400.0], data);
	}

	public function testClone() {
		var other:ArpTransform = me.clone();
		var data:Array<Float> = other.toData();
		assertNotEquals(me, other);
		assertMatch([1.0, 0.0, 0.0, 2.0, 300.0, 400.0], data);
	}

	public function testCopyFrom() {
		var other:ArpTransform = new ArpTransform();
		var data:Array<Float> = other.copyFrom(me).toData();
		assertMatch([1.0, 0.0, 0.0, 2.0, 300.0, 400.0], data);
	}

	public function testSetXY() {
		me.setXY(256.0, 512.0);
		assertMatch([1.0, 0.0, 0.0, 2.0, 256.0, 512.0], data);
	}

	public function testPrependXY() {
		me.prependXY(256.0, 512.0);
		assertMatch([1.0, 0.0, 0.0, 2.0, 556.0, 1424.0], data);
		assertMatch(newMe.prependTransform(new ArpTransform().reset(1.0, 0.0, 0.0, 1.0, 256.0, 512.0)).toData(), data);
	}

	public function testPrependTransformSimple() {
		me.prependTransform(new ArpTransform().reset(3.0, 0.0, 0.0, 1.0, 10.0, 20.0));
		assertMatch([3.0, 0.0, 0.0, 2.0, 310.0, 440.0], data);
	}

	public function testAppendXY() {
		me.appendXY(256.0, 512.0);
		assertMatch([1.0, 0.0, 0.0, 2.0, 556.0, 912.0], data);
		assertMatch(newMe.appendTransform(new ArpTransform().reset(1.0, 0.0, 0.0, 1.0, 256.0, 512.0)).toData(), data);
	}

	public function testAppendTransformSimple() {
		me.appendTransform(new ArpTransform().reset(3.0, 0.0, 0.0, 1.0, 10.0, 20.0));
		assertMatch([3.0, 0.0, 0.0, 2.0, 910.0, 420.0], data);
	}
}
