package arpx;

import picotest.PicoTest;

class ArpEngineAllTests {
	static function main() {
		var r = PicoTest.runner();
		ArpEngineTestSuite.addTo(r);
		r.run();
	}
}
