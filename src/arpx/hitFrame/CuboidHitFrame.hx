package arpx.hitFrame;

import arp.hit.structs.HitGeneric;
import arpx.structs.ArpHitCuboid;
import arpx.structs.ArpPosition;

@:arpType("hitFrame", "cuboid")
class CuboidHitFrame extends HitFrame {

	@:arpField public var hitCuboid:ArpHitCuboid;

	public function new() {
		super();
	}

	override public function exportHitGeneric(base:ArpPosition, source:HitGeneric):HitGeneric {
		return source.setCuboid(
			base.x + this.hitCuboid.dX,
			base.y + this.hitCuboid.dY,
			base.z + this.hitCuboid.dZ,
			this.hitCuboid.sizeX,
			this.hitCuboid.sizeY,
			this.hitCuboid.sizeZ
		);
	}

	override public function mapTo(base:ArpPosition, targetBase:ArpPosition, target:HitFrame, input:ArpPosition, output:ArpPosition = null):ArpPosition {
		var tFrame:CuboidHitFrame = try cast(target, CuboidHitFrame) catch (e:Dynamic) null;
		if (tFrame != null) {
			var tCuboid:ArpHitCuboid = tFrame.hitCuboid;
			if (output == null) output = new ArpPosition(targetBase.x, targetBase.y, targetBase.z, input.dir.value);
			var sizeX:Float = this.hitCuboid.sizeX;
			if (sizeX > 0) {
				output.x += (input.x - base.x - this.hitCuboid.dX) / sizeX * tCuboid.sizeX + tCuboid.dX;
			}
			var sizeY:Float = this.hitCuboid.sizeY;
			if (sizeY > 0) {
				output.y += (input.y - base.y - this.hitCuboid.dY) / sizeY * tCuboid.sizeY + tCuboid.dY;
			}
			var sizeZ:Float = this.hitCuboid.sizeZ;
			if (sizeZ > 0) {
				output.x += (input.z - base.z - this.hitCuboid.dZ) / sizeZ * tCuboid.sizeZ + tCuboid.dZ;
			}
			return output;
		}
		return null;
	}
}


