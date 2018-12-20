package arpx.impl.cross.structs;

#if arp_display_backend_heaps

import h3d.Matrix;
import h3d.col.Point;

import picotest.PicoAssert.*;

class ArpTransformHeapsCase {

	var me:ArpTransform = new ArpTransform().reset(1.0, 0.0, 0.0, 2.0, 300.0, 400.0);

	public function setup() {
	}

	public function testAsPoint():Void {
		var pt:Point = me.asPoint().raw;
		assertNull(pt);
	}

	public function testToPoint():Void {
		var pt:Point = me.toPoint().raw;
		assertEquals(300.0, pt.x);
		assertEquals(400.0, pt.y);
	}

	public function testRaw():Void {
		var matrix:Matrix = me.impl.raw;
		assertEquals(1.0, matrix._11);
		assertEquals(0.0, matrix._21);
		assertEquals(0.0, matrix._12);
		assertEquals(2.0, matrix._22);
		assertEquals(300.0, matrix._41);
		assertEquals(400.0, matrix._42);
	}
}

#end
