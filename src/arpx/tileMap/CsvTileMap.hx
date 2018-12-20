package arpx.tileMap;

@:arpType("tileMap", "csv")
class CsvTileMap extends ArrayTileMap {

	@:arpField("value") public var data:String;

	public function new() {
		super();
	}

	private function arrayContentToInt(item:String):Int {
		return faceList != null ? faceList.indexOf(item) : Std.parseInt(item);
	}

	override private function heatUp():Bool {
		if (this.map == null) {
			this.map = [];
			if (this.data != null) {
				for (row in ~/\s*(?:\r|\n|\r\n)+\s*/g.split(this.data)) {
					if (row != "") {
						var rowData:Array<Int> = ~/\s*,\s*/g.split(row).map(arrayContentToInt);
						this.map.push(rowData);
						if (this.width < rowData.length) this.width = rowData.length;
					}
				}
			}
		}
		if (this.height < this.map.length) this.height = this.map.length;
		return true;
	}
}


