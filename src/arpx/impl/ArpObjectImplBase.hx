package arpx.impl;

import arp.impl.IArpObjectImpl;

class ArpObjectImplBase implements IArpObjectImpl {
	public function new() return;

	@:noDoc @:noCompletion public function __arp_heatUpNow():Bool return arpHeatUp();
	@:noDoc @:noCompletion public function __arp_heatDownNow():Bool return arpHeatDown();
	@:noDoc @:noCompletion public function __arp_dispose():Void arpDispose();

	public function arpHeatUp():Bool return true;
	public function arpHeatDown():Bool return true;
	public function arpDispose():Void return;
}


