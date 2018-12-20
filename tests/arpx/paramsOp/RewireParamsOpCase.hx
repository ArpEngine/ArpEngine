package arpx.paramsOp;

import arp.domain.ArpDomain;
import arp.seed.ArpSeed;
import arpx.structs.ArpParams;
import arpx.structs.IArpParamsRead;

import picotest.PicoAssert.*;
import org.hamcrest.Matchers.*;

class RewireParamsOpCase {

	private var domain:ArpDomain;
	private var me:RewireParamsOp;

	public function setup() {
		var xml:Xml = Xml.parse('<paramsOp class="rewire" name="me" fixedParams="k1:a1,k2:a2" rewireParams="k3:k4" />').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		domain = new ArpDomain();
		domain.addTemplate(RewireParamsOp);
		domain.loadSeed(seed);
		me = domain.query("me", RewireParamsOp).value();
	}

	public function testFilterEmpty():Void {
		var inParams:ArpParams = new ArpParams();
		var params:IArpParamsRead = me.filter(inParams);
		assertMatch('a1', params.get('k1'));
		assertMatch('a2', params.get('k2'));
		assertMatch(null, params.get('k3'));

		// var keys:Array<String> = [];
		// for (k in params.keys()) keys.push(k);
		// assertMatch(containsInAnyOrder('k1', 'k2', 'k3'), keys);
	}

	public function testFilter():Void {
		var inParams:ArpParams = new ArpParams();
		inParams.set('k1', 'b1');
		inParams.set('k2', 'b2');
		inParams.set('k3', 'b3');
		inParams.set('k4', 'b4');
		inParams.set('k5', 'b5');

		var params:IArpParamsRead = me.filter(inParams);
		assertMatch('a1', params.get('k1'));
		assertMatch('a2', params.get('k2'));
		assertMatch('b4', params.get('k3'));
		assertMatch(null, params.get('k4'));
		assertMatch(null, params.get('k5'));


		// var keys:Array<String> = [];
		// for (k in params.keys()) keys.push(k);
		// assertMatch(containsInAnyOrder('k1', 'k2', 'k3'), keys);
	}

	public function testFilterWithCopy():Void {
		var inParams:ArpParams = new ArpParams();
		inParams.set('k1', 'b1');
		inParams.set('k2', 'b2');
		inParams.set('k3', 'b3');
		inParams.set('k4', 'b4');
		inParams.set('k5', 'b5');

		me.copy = true;
		var params:IArpParamsRead = me.filter(inParams);
		assertMatch('a1', params.get('k1'));
		assertMatch('a2', params.get('k2'));
		assertMatch('b4', params.get('k3'));
		assertMatch('b4', params.get('k4'));
		assertMatch('b5', params.get('k5'));


		// var keys:Array<String> = [];
		// for (k in params.keys()) keys.push(k);
		// assertMatch(containsInAnyOrder('k1', 'k2', 'k3', 'k4', 'k5'), keys);
	}
}
