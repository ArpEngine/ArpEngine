package arpx.chip.stringChip;

class StringChipStringIterator {

	private var chipName:String = "";
	private var i:Int = 0;
	private var c:Int = 0;

	public function new(chipName:String) {
		if (chipName != null) {
			this.chipName = chipName;
			this.c = chipName.length;
		}
	}

	public function hasNext():Bool {
		return this.i < this.c;
	}

	public function next():String {
		var char:String = this.chipName.charAt(this.i++);
		switch (char) {
			case " ":
				return "/space/";
			case "\t", "\n":
				return char;
			case "/":
				var j:Int = this.chipName.indexOf("/", this.i);
				if (j < 0) return "/";
				char = this.chipName.substring(this.i - 1, ++j);
				this.i = j;
				switch (char) {
					case "/ /": return "\n";
				}
		}
		return char;
	}
}
