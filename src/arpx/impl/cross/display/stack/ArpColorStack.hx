package arpx.impl.cross.display.stack;

import arpx.structs.ArpColor;

class ArpColorStack extends ArpStructStack<ArpColor> {
	public function new() super();

	override private function create():ArpColor return new ArpColor(0xffffffff);
	override private function copyFrom(me:ArpColor, value:ArpColor):ArpColor return me.copyFrom(value);
	override private function clone(me:ArpColor):ArpColor return me.clone();
}
