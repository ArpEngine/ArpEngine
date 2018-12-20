package arpx.hitFrame;

import arp.domain.IArpObject;
import arp.hit.structs.HitGeneric;
import arpx.field.Field;
import arpx.mortal.Mortal;
import arpx.structs.ArpPosition;

@:arpType("hitFrame", "null")
class HitFrame implements IArpObject {

	@:arpField public var hitType:String;

	public function new() {
	}

	public function exportHitGeneric(base:ArpPosition, source:HitGeneric):HitGeneric {
		return source;
	}

	public function updateHitMortal(field:Field, mortal:Mortal):Void {
		this.exportHitGeneric(mortal.position, field.addHit(mortal, this.hitType));
	}

	public function mapTo(base:ArpPosition, targetBase:ArpPosition, target:HitFrame, input:ArpPosition, output:ArpPosition = null):ArpPosition {
		if (output != null) return output;
		return input.clone();
	}
}


