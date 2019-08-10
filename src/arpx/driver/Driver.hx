package arpx.driver;

import arp.domain.IArpObject;
import arpx.field.Field;
import arpx.mortal.Mortal;

@:arpType("driver", "null")
class Driver implements IArpObject {

	@:arpField public var dHitType:String;

	public function new() {
	}

	public function tick(field:Field, mortal:Mortal):Void {
	}

	public function towardD(mortal:Mortal, period:Float, x:Float = 0, y:Float = 0, z:Float = 0):Bool {
		return false;
	}

	public function startAction(mortal:Mortal, actionName:String, restart:Bool = false):Bool {
		return false;
	}
}


