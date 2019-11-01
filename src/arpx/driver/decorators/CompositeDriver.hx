package arpx.driver.decorators;

import arp.task.Heartbeat;
import arp.ds.IList;
import arpx.field.Field;
import arpx.mortal.Mortal;

@:arpType("driver", "composite")
class CompositeDriver extends Driver {

	@:arpBarrier @:arpDeepCopy @:arpField(true) public var drivers:IList<Driver>;

	override public function get_time():Float {
		var t:Float = 0;
		for (driver in this.drivers) {
			t = driver.time;
			if (t != 0) break;
		}
		return t;
	}

	public function new() super();

	override public function towardD(mortal:Mortal, time:Float, x:Float = 0, y:Float = 0, z:Float = 0):Bool {
		for (driver in this.drivers) {
			if (driver.towardD(mortal, time, x, y, z)) return true;
		}
		return false;
	}

	override public function startAction(mortal:Mortal, actionName:String, restart:Bool = false):Bool {
		for (driver in this.drivers) {
			if (driver.startAction(mortal, actionName, restart)) return true;
		}
		return false;
	}

	override public function tick(field:Field, mortal:Mortal):Heartbeat {
		for (driver in drivers) driver.tick(field, mortal);
		return Heartbeat.Keep;
	}
}


