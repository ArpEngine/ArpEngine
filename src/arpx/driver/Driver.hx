package arpx.driver;

import arp.domain.IArpObject;
import arpx.field.Field;
import arpx.mortal.Mortal;

@:arpType("driver", "null")
class Driver implements IArpObject {

	public function new() {
	}

	public function tick(field:Field, mortal:Mortal):Void {
	}

	public function startAction(mortal:Mortal, actionName:String, restart:Bool = false):Bool {
		return false;
	}
}


