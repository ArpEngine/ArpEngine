package arpx.driver;

import arpx.field.Field;
import arpx.mortal.Mortal;
import arpx.structs.ArpPosition;

@:arpType("driver", "linear")
class LinearDriver extends Driver {

	@:arpField public var dPos:ArpPosition;
	@:arpField public var hasDir:Bool;
	@:arpField public var nowTime:Float = 0;
	@:arpField public var time:Float = 0;

	public function new() super();

	override public function towardD(mortal:Mortal, time:Float, x:Float = 0, y:Float = 0, z:Float = 0):Bool {
		this.dPos.x = x;
		this.dPos.y = y;
		this.dPos.z = z;
		if (x != 0 || y != 0) {
			this.dPos.dir.valueRadian = Math.atan2(y, x);
			this.hasDir = true;
		}
		this.time = time;
		this.nowTime = 0;
		return true;
	}

	override public function tick(field:Field, mortal:Mortal):Void {
		if (this.time <= 0) {
			mortal.stayWithHit(field, this.dHitType);
			return;
		}

		var pos:ArpPosition = mortal.position;
		if (this.hasDir) {
			pos.dir.value = this.dPos.dir.value;
			mortal.params.set("dir", pos.dir);
		}
		var dx = this.dPos.x / time;
		var dy = this.dPos.y / time;
		var dz = this.dPos.z / time;

		var dTime = this.time - this.nowTime;
		if (dTime < 1) {
			dx *= dTime;
			dy *= dTime;
			dz *= dTime;
			this.nowTime = this.time = 0;
		} else {
			this.nowTime++;
		}
		mortal.moveDWithHit(field, dx, dy, dz, this.dHitType);
	}
}


