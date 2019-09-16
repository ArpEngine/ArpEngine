package arpx.external.procs;

import arp.ds.IList;
import arpx.proc.Proc;

@:arpType("proc", "external.load")
class ProcExternalLoad extends Proc {

	@:arpField(true) public var externals:IList<External>;
	@:arpField public var nonblocking:Bool = true;

	public function new() super();

	override public function execute():Void {
		for (external in this.externals) {
			external.arpHeatLater(nonblocking);
		}
	}
}

@:arpType("proc", "external.reload")
class ProcExternalReload extends Proc {

	@:arpField(true) public var externals:IList<External>;
	@:arpField public var gc:Bool = true;

	public function new() super();

	override public function execute():Void {
		arpDomain.allowOverwrite = true;
		for (external in this.externals) {
			external.arpHeatDownNow();
			external.arpHeatLater(false);
		}
		if (gc) arpDomain.gc();
		arpDomain.heatUpkeep();
	}
}
