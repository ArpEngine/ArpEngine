package arpx.impl.cross.display.stack;

import arpx.impl.cross.structs.ArpTransform;

class ArpTransformStack extends ArpStructStack<ArpTransform> {
	public function new() super();

	override private function create():ArpTransform return new ArpTransform();
	override private function copyFrom(me:ArpTransform, value:ArpTransform):ArpTransform return me.copyFrom(value);
	override private function clone(me:ArpTransform):ArpTransform return me.clone();
}
