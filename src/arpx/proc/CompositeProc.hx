package arpx.proc;

import arp.ds.IList;

@:arpType("proc", "composite")
class CompositeProc extends Proc {

	@:arpField(true) public var procs:IList<Proc>;

	public function new() {
		super();
	}

	override public function execute():Void {
		for (proc in this.procs) proc.execute();
	}
}
