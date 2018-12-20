package arpx.chip.stringChip;

import arp.iterators.SimpleArrayIterator;
import arpx.impl.cross.geom.RectImpl;
import arpx.structs.IArpParamsRead;

class StringChipTypeset {

	private var chip:StringChip;
	private var font:StringChipFont;

	private var face:String;
	private var chars:Array<StringChipTypesetChar>;

	inline public function iterator():SimpleArrayIterator<StringChipTypesetChar> return new SimpleArrayIterator(chars);

	public function new(chip:StringChip, params:IArpParamsRead) {
		this.chip = chip;
		this.font = StringChipFont.cached(chip.chip, params);
		this.face = params.get("face");
		this.chars = [];

		for (char in new StringChipStringIterator(this.face)) {
			this.chars.push(new StringChipTypesetChar(this, 0, 0, char));
		}

		var x:Float = 0;
		var y:Float = 0;
		var i:Int = 0;
		var lastSpace:Int = -1;
		var len:Int = this.chars.length;

		inline function newLine(lineHeight:Float):Void {
			x = 0;
			lastSpace = -1;
			y += lineHeight;
		}
		while (i < len) {
			var tChar:StringChipTypesetChar = this.chars[i];
			var char:String = tChar.char;
			var childFaceSize:RectImpl = this.font.getCharChipSize(char);
			switch (char) {
				case "/space/":
					x += childFaceSize.width;
					lastSpace = i;
					tChar.dX = Math.NaN;
				case "\t":
					x += childFaceSize.width * 4;
					lastSpace = i;
					tChar.dX = Math.NaN;
				case "\n":
					newLine(childFaceSize.height);
					tChar.dX = Math.NaN;
				default:
					if (chip.chipWidth > 0 && x + childFaceSize.width > chip.chipWidth) {
						if (lastSpace != -1) {
							// backtrack to after last space and line feed
							i = lastSpace + 1;
							newLine(childFaceSize.height);
							continue;
						}
						// force linefeed
						newLine(childFaceSize.height);
					}
					tChar.dX = x;
					tChar.dY = y;
					x += childFaceSize.width;
			}
			i++;
		}
	}

	public function match(chip:StringChip, params:IArpParamsRead):Bool {
		if (chip != this.chip) return false;
		if (params.get("face") != this.face) return false;
		if (StringChipFont.cached(chip.chip, params) != this.font) return false;
		return true;
	}

	inline public static function cached(chip:StringChip, params:IArpParamsRead):StringChipTypeset return StringChipTypesetCache.instance.get(chip, params);
}

