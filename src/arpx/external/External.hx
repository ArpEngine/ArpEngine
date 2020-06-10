package arpx.external;

import arp.seed.ArpSeedEnv;
import arp.data.DataGroup;
import arp.seed.ArpSeed;
import arp.domain.IArpObject;

@:arpType("external", "external")
class External implements IArpObject {

	private var data:DataGroup;
	private var env:ArpSeedEnv;

	public function new() return;

	@:arpLoadSeed
	private function loadSeed(seed:ArpSeed):Void {
		if (seed != null) this.env = seed.env;
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

	final public function load(force:Bool = false):Bool {
		if (this.data != null && !force) {
			return true;
		}
		this.data = this.arpDomain.allocObject(DataGroup);
		this.data.arpSlot.addReference();
		if (!this.doLoad(this.data)) {
			this.unload();
			return false;
		}
		return true;
	}

	final public function unload():Void {
		if (this.data != null) {
			this.doUnload(this.data);
			this.data.arpSlot.delReference();
			this.data = null;
		}
	}

	private function doLoad(data:DataGroup):Bool return false; //override
	private function doUnload(data:DataGroup):Void return; //override
}
