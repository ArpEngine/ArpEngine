package arpx.impl;

import arp.impl.IArpObjectImpl;

class ArpObjectImplBase implements IArpObjectImpl {
	public function new() return;

	@:noDoc @:noCompletion public function __arp_dispose():Void arpDisposeNow();

	public function arpHeatUpNow():Bool return true;
	public function arpHeatDownNow():Bool return true;
	public function arpDisposeNow():Void return;
}


