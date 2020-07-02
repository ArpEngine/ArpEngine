package arpx.impl.cross.fieldGizmo;

import arp.hit.structs.HitGeneric;
import arpx.field.Field;
import arpx.fieldGizmo.AnchorFieldGizmo;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.display.RenderContext;
import arpx.impl.cross.fieldGizmo.IFieldGizmoImpl;
import arpx.structs.ArpPosition;

class AnchorFieldGizmoImpl extends ArpObjectImplBase implements IFieldGizmoImpl {

	private var fieldGizmo:AnchorFieldGizmo;

	public function new(fieldGizmo:AnchorFieldGizmo) {
		super();
		this.fieldGizmo = fieldGizmo;
	}

	public function exportHitGeneric(base:ArpPosition, source:HitGeneric):HitGeneric {
		return source;
	}

	private static var _workHit:HitGeneric = new HitGeneric();
	public function render(field:Field, context:RenderContext):Void {
		if (this.fieldGizmo.visible) {
			var hit:HitGeneric = _workHit;
			for (anchor in field.anchors) {
				anchor.hitFrame.exportHitGeneric(anchor.position, hit);

				var x:Int = Math.round(hit.x);
				var y:Int = Math.round(hit.y);
				var sX:Int = Math.round(hit.sizeX);
				var sY:Int = Math.round(hit.sizeY);
				context.tints.dup().applyMul(fieldGizmo.hitColorFor(anchor));
				context.fillRect(x - sX, y - sY, 1, sY * 2);
				context.fillRect(x + sX, y - sY, 1, sY * 2);
				context.fillRect(x - sX, y - sY, sX * 2, 1);
				context.fillRect(x - sX, y + sY, sX * 2, 1);
				context.tints.pop();
			}
		}
	}
}
