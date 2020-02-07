package arpx.proc;

import arp.domain.ArpDomain;

@:arpType("proc", "dynamic")
class DynamicProc extends Proc {

	public function new() super();

	override public function execute():Void onExecute();

	dynamic public function onExecute():Void return;

	public static function allocDynamicProc(arpDomain:ArpDomain, execute:()->Void):DynamicProc {
		var result:DynamicProc = arpDomain.allocObject(DynamicProc);
		result.onExecute = execute;
		return result;
	}

	@:noUsing
	inline public static function allocObject(arpDomain:ArpDomain, execute:()->Void):DynamicProc return allocDynamicProc(arpDomain, execute);
}
