package arpx.motionFrame;

import arp.domain.IArpObject;
import arp.ds.ISet;
import arpx.field.Field;
import arpx.hitFrame.HitFrame;
import arpx.mortal.Mortal;
import arpx.structs.ArpParams;
import arpx.structs.ArpPosition;

@:arpType("motionFrame", "motionFrame")
class MotionFrame implements IArpObject {

	@:arpField public var params:ArpParams;
	@:arpField(true) public var hitFrames:ISet<HitFrame>;
	@:arpField public var time:Float;
	@:arpField public var dX:Float;
	@:arpField public var dY:Float;
	@:arpField public var dZ:Float;
	@:arpField public var dR:Float;
	@:arpField public var dS:Float;
	@:arpField public var ddX:Float;
	@:arpField public var ddY:Float;
	@:arpField public var ddZ:Float;
	@:arpField public var ddR:Float;
	@:arpField public var ddS:Float;

	public function new() {
	}

	public function updateShadowPosition(shadow:Mortal, oldTime:Float, newTime:Float):Void {
		var factor:Float = newTime - oldTime;
		var pos:ArpPosition = shadow.position;
		var dX:Float = this.dX + this.dR * Math.cos(pos.dir.valueRadian) + this.dS * Math.sin(pos.dir.valueRadian);
		var dY:Float = this.dY + this.dR * Math.sin(pos.dir.valueRadian) - this.dS * Math.cos(pos.dir.valueRadian);
		var dZ:Float = this.dZ;
		dX *= factor;
		dY *= factor;
		dZ *= factor;

		pos.x += dX;
		pos.y += dY;
		pos.z += dZ;
	}

	public function updateMortalPosition(field:Field, mortal:Mortal, oldTime:Float, newTime:Float, dHitType:String):Void {
		var factor:Float = newTime - oldTime;
		var pos:ArpPosition = mortal.position;
		var dX:Float = this.dX + this.dR * Math.cos(pos.dir.valueRadian) + this.dS * Math.sin(pos.dir.valueRadian);
		var dY:Float = this.dY + this.dR * Math.sin(pos.dir.valueRadian) - this.dS * Math.cos(pos.dir.valueRadian);
		var dZ:Float = this.dZ;
		dX *= factor;
		dY *= factor;
		dZ *= factor;

		mortal.hitFrames.clear();
		for (hitFrame in this.hitFrames) mortal.hitFrames.add(hitFrame);
		mortal.moveDWithHit(field, dX, dY, dZ, dHitType);
	}
}
