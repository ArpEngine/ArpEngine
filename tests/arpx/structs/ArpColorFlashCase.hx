package arpx.structs;

#if openfl
import openfl.geom.ColorTransform;
#elseif flash
import flash.geom.ColorTransform;
#end

import org.hamcrest.Matchers;
import picotest.PicoAssert.*;

class ArpColorFlashCase {

	#if (flash || openfl)

	public function testToMultiplier():Void {
		var color:ArpColor = new ArpColor(0x336699);
		color.alpha = 0xcc;
		var ct:ColorTransform = color.toMultiplier();
		assertMatch(0.2, ct.redMultiplier);
		assertMatch(0.4, ct.greenMultiplier);
		assertMatch(0.6, ct.blueMultiplier);
		assertMatch(0.8, ct.alphaMultiplier);
		assertMatch(0, ct.redOffset);
		assertMatch(0, ct.greenOffset);
		assertMatch(0, ct.blueOffset);
		assertMatch(0, ct.alphaOffset);
	}

	public function testToOffset():Void {
		var color:ArpColor = new ArpColor(0x336699);
		color.alpha = 0xcc;
		var ct:ColorTransform = color.toOffset();
		assertMatch(0, ct.redMultiplier);
		assertMatch(0, ct.greenMultiplier);
		assertMatch(0, ct.blueMultiplier);
		assertMatch(0, ct.alphaMultiplier);
		assertMatch(0x33, ct.redOffset);
		assertMatch(0x66, ct.greenOffset);
		assertMatch(0x99, ct.blueOffset);
		assertMatch(0xcc, ct.alphaOffset);
	}

	public function testToColorize():Void {
		var ERR:Float = 0.01;
		var color:ArpColor = new ArpColor(0x336699);
		color.alpha = 0xcc;
		var ct:ColorTransform = color.toColorize();
		assertMatch(Matchers.closeTo(0x33 / 0xff, ERR), ct.redMultiplier);
		assertMatch(Matchers.closeTo(0x33 / 0xff, ERR), ct.greenMultiplier);
		assertMatch(Matchers.closeTo(0x33 / 0xff, ERR), ct.blueMultiplier);
		assertMatch(Matchers.closeTo(0xff / 0xff, ERR), ct.alphaMultiplier);
		assertMatch(Matchers.closeTo(0x33 * 0xcc / 0xff, ERR), ct.redOffset);
		assertMatch(Matchers.closeTo(0x66 * 0xcc / 0xff, ERR), ct.greenOffset);
		assertMatch(Matchers.closeTo(0x99 * 0xcc / 0xff, ERR), ct.blueOffset);
		assertMatch(0, ct.alphaOffset);
	}

	#end

}

