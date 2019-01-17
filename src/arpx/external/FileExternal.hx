package arpx.external;

import haxe.io.Bytes;
import arp.data.DataGroup;
import arp.domain.ArpUntypedSlot;
import arp.domain.IArpObject;
import arp.seed.ArpSeed;
import arp.seed.ArpSeedEnv;
import arpx.file.File;

@:arpType("external", "file")
class FileExternal extends External {

	@:arpField @:arpBarrier public var file:File;
	@:arpField public var format:String;
	@:arpField public var defaultType:String;

	private var data:DataGroup;
	private var env:ArpSeedEnv;

	public function new() {
		super();
	}

	// NOTE hack to acquire ArpSeedEnv
	override public function __arp_init(slot:ArpUntypedSlot, seed:ArpSeed):IArpObject {
		this.env = seed.env();
	}

	@:arpHeatUp
	private function heatUp():Bool {
		this.load();
		return true;
	}

	@:arpHeatDown
	private function heatDown():Bool {
		this.unload();
		return true;
	}

	override public function load(force:Bool = false):Void {
		if (this.data != null && !force) {
			return;
		}
		var bytes:Bytes = this.file.bytes();
		if (bytes != null) {
			this.data = this.arpDomain.allocObject(DataGroup);
			var seed:ArpSeed = switch (this.format) {
				case "csv": ArpSeed.fromCsvBytes(bytes, defaultType, env);
				case "tsv": ArpSeed.fromTsvBytes(bytes, defaultType, env);
				case _: ArpSeed.fromXmlBytes(bytes, env);
			}
			this.data.add(this.arpDomain.loadSeed(seed));
		}
	}

	override public function unload():Void {
		if (this.data != null) {
			this.data.arpSlot.delReference();
			this.data = null;
		}
	}

}
