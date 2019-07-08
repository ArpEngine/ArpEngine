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
			external.arpDomain.heatLater(external.arpSlot, nonblocking);
		}
	}
}

@:arpType("proc", "external.reload")
class ProcExternalReload extends Proc {

	@:arpField(true) public var externals:IList<External>;
	@:arpField public var gc:Bool = true;

	public function new() super();

	override public function execute():Void {
		for (external in this.externals) {
			external.arpDomain.heatDown(external.arpSlot);
			external.arpDomain.heatLater(external.arpSlot, false);
		}
		if (gc) arpDomain.gc();
	}
}
