package arpx.external;

import arp.data.DataGroup;
import arp.seed.ArpSeed;
import arpx.file.File;
import haxe.io.Bytes;

@:arpType("external", "file")
class FileExternal extends External {

	@:arpField @:arpBarrier(true, true) public var file:File;
	@:arpField public var format:String;
	@:arpField public var defaultType:String;

	public function new() {
		super();
	}

	override public function doLoad(data:DataGroup):Bool {
		var bytes:Bytes = this.file.bytes();
		if (bytes == null) return false;
		var seed:ArpSeed = switch (this.format) {
			case "csv": ArpSeed.fromCsvBytes(bytes, defaultType, env);
			case "tsv": ArpSeed.fromTsvBytes(bytes, defaultType, env);
			case _: ArpSeed.fromXmlBytes(bytes, env);
		}
		data.add(this.arpDomain.loadSeed(seed));
		return true;
	}
}
