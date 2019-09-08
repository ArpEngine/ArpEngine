package arpx.proc;

@:arpType("proc", "dynamic")
class DynamicProc extends Proc {

	public function new() super();

	override public function execute():Void onExecute();

	dynamic public function onExecute():Void return;
}
