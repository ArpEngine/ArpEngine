package arpx.impl.cross.structs;

#if arp_display_backend_flash

import flash.geom.Matrix;
import flash.geom.Point;

import picotest.PicoAssert.*;

class ArpTransformFlashCase {

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
		assertEquals(1.0, matrix.a);
		assertEquals(0.0, matrix.b);
		assertEquals(0.0, matrix.c);
		assertEquals(2.0, matrix.d);
		assertEquals(300.0, matrix.tx);
		assertEquals(400.0, matrix.ty);
	}
}

#end
