package arpx.anchor;

import arp.domain.IArpObject;
import arpx.field.Field;
import arpx.hitFrame.HitFrame;
import arpx.structs.ArpPosition;

@:arpType("anchor")
class Anchor implements IArpObject {

	@:arpField public var position:ArpPosition;
	@:arpField public var hitFrame:HitFrame;

	public function new() {
	}

	public function refresh(field:Field):Void {
		hitFrame.exportHitGeneric(new ArpPosition(), field.addAnchorHit(this));
	}

}


