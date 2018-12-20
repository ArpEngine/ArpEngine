package arpx.driver;

import arpx.field.Field;
import arpx.mortal.Mortal;
import arpx.structs.ArpPosition;

@:arpType("driver", "linear")
class LinearDriver extends Driver {

	@:arpField public var target:ArpPosition;
	@:arpField public var isDelta:Bool;
	@:arpField public var dHitType:String;
	@:arpField public var period:Float;

	public function new() {
		super();
	}

	inline public function toward(period:Float, x:Float, y:Float, z:Float = 0, gridSize:Float = 1.0):Void {
		this.target.x = x * gridSize;
		this.target.y = y * gridSize;
		this.target.z = z * gridSize;
		this.isDelta = false;
		this.period = period;
	}

	inline public function towardD(period:Float, x:Float = 0, y:Float = 0, z:Float = 0, gridSize:Float = 1.0):Void {
		this.target.x = x * gridSize;
		this.target.y = y * gridSize;
		this.target.z = z * gridSize;
		this.isDelta = true;
		this.period = period;
	}

	override public function tick(field:Field, mortal:Mortal):Void {
		if (this.period <= 0) {
			mortal.stayWithHit(field, this.dHitType);
			return;
		}

		var pos:ArpPosition = mortal.position;
		if (this.isDelta) {
			if (this.target.x != 0 || this.target.y != 0) {
				var valueRadian:Float = Math.atan2(this.target.y, this.target.x);
				pos.dir.valueRadian = valueRadian;
				mortal.params.set("dir", pos.dir);
			}
			var dx:Float;
			var dy:Float;
			var dz:Float;
			if (this.period < 1) {
				dx = this.target.x;
				dy = this.target.y;
				dz = this.target.z;
				this.period = 0;
			} else {
				dx = this.target.x / this.period;
				dy = this.target.y / this.period;
				dz = this.target.z / this.period;
				this.period--;
			}
			mortal.moveDWithHit(field, dx, dy, dz, this.dHitType);
			this.target.x -= dx;
			this.target.y -= dy;
			this.target.z -= dz;
		} else {
			if (this.target.x != pos.x || this.target.y != pos.y) {
				var valueRadian:Float = Math.atan2(this.target.y - pos.y, this.target.x - pos.x);
				pos.dir.valueRadian = valueRadian;
				mortal.params.set("dir", pos.dir);
			}
			var x:Float;
			var y:Float;
			var z:Float;
			if (this.period < 1) {
				this.period = 0;
				x = this.target.x;
				y = this.target.y;
				z = this.target.z;
			} else {
				var p:Float = this.period--;
				x = (pos.x * this.period + this.target.x) / p;
				y = (pos.y * this.period + this.target.y) / p;
				z = (pos.z * this.period + this.target.z) / p;
			}
			mortal.moveWithHit(field, x, y, z, this.dHitType);
		}
	}
}


