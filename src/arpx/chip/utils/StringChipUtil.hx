package arpx.chip.utils;

class StringChipUtil {

	public static function lengthForStringChip(str:String):Int {
		var b:Bool = false;
		var outer:Int = 0;
		var inner:Int = 0;
		for (i in 0...str.length) {
			switch (str.charCodeAt(i)) {
				case "/".code:
					if (b = !b) inner = 1; else { outer++; inner = 0; }
				case _:
					if (b) inner++ else outer++;
			}
		}
		return outer+ inner;
	}
}
