package arpx.chip.utils;

import arpx.chip.stringChip.StringChipStringIterator;
import picotest.PicoAssert.*;

class StringChipUtilCase {

	private function len(str:String):Int return StringChipUtil.lengthForStringChip(str);
	private function lenIter(str:String):Int return [for (x in new StringChipStringIterator(str)) x].length;

	public function testLengthForStringChip() {
		assertEquals(0, len(""));
		assertEquals(4, len("1234"));
		assertEquals(1, len("/space/"));
		assertEquals(2, len("////"));
		assertEquals(9, len("123/444/567/888/9"));
		assertEquals(5, len("12/45"));
		assertEquals(9, len("12/333/45/789"));
	}

	public function testStringChipStringIterator() {
		assertEquals(lenIter(""), len(""));
		assertEquals(lenIter("1234"), len("1234"));
		assertEquals(lenIter("/space/"), len("/space/"));
		assertEquals(lenIter("////"), len("////"));
		assertEquals(lenIter("123/444/567/888/9"), len("123/444/567/888/9"));
		assertEquals(lenIter("12/45"), len("12/45"));
		assertEquals(lenIter("12/333/45/678"), len("12/333/45/678"));
	}
}
