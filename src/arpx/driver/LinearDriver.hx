package arpx.driver;

import arpx.field.Field;
import arpx.mortal.Mortal;
import arpx.structs.ArpPosition;

@:arpType("driver", "linear")
class LinearDriver extends Driver {

	@:arpField public var dPos:ArpPosition;
	@:arpField public var hasDir:Bool;
	@:arpField public var time:Float;
	@:arpField public var period:Float;

	public function new() {
		super();
	}

	override public function towardD(mortal:Mortal, period:Float, x:Float = 0, y:Float = 0, z:Float = 0):Bool {
		this.dPos.x = x;
		this.dPos.y = y;
		this.dPos.z = z;
		if (x != 0 || y != 0) {
			this.dPos.dir.valueRadian = Math.atan2(y, x);
			this.hasDir = true;
		}
		this.period = period;
		this.time = 0;
		return true;
	}

	override public function tick(field:Field, mortal:Mortal):Void {
		if (this.period <= 0) {
			mortal.stayWithHit(field, this.dHitType);
			return;
		}

		var pos:ArpPosition = mortal.position;
		if (this.hasDir) {
			pos.dir.value = this.dPos.dir.value;
			mortal.params.set("dir", pos.dir);
		}
		var dx = this.dPos.x / period;
		var dy = this.dPos.y / period;
		var dz = this.dPos.z / period;

		var dTime = this.period - this.time;
		if (dTime < 1) {
			dx *= dTime;
			dy *= dTime;
			dz *= dTime;
			this.time = this.period;
		} else {
			this.time++;
		}
		mortal.moveDWithHit(field, dx, dy, dz, this.dHitType);
	}
}


