package arpx.motionTween;

import arpx.structs.ArpPosition;

@:arpType("motionTween", "physical")
class PhysicalMotionTween extends MotionTween {

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

	public function new() super();

	override public function updateShadowPosition(position:ArpPosition, target:ArpPosition, oldTime:Float, newTime:Float, nextTime:Float):Void {
		var factor:Float = newTime - oldTime;
		var dX:Float = this.dX + this.dR * Math.cos(position.dir.valueRadian) + this.dS * Math.sin(position.dir.valueRadian);
		var dY:Float = this.dY + this.dR * Math.sin(position.dir.valueRadian) - this.dS * Math.cos(position.dir.valueRadian);
		var dZ:Float = this.dZ;
		dX *= factor;
		dY *= factor;
		dZ *= factor;

		position.x += dX;
		position.y += dY;
		position.z += dZ;
	}
}
