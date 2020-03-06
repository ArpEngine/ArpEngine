package arpx.impl.cross.fieldGizmo;

import arpx.field.Field;
import arpx.fieldGizmo.HitMortalFieldGizmo;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.display.RenderContext;
import arpx.impl.cross.fieldGizmo.IFieldGizmoImpl;
import arpx.structs.ArpColor;

class HitMortalFieldGizmoImpl extends ArpObjectImplBase implements IFieldGizmoImpl {

	private var fieldGizmo:HitMortalFieldGizmo;

	public function new(fieldGizmo:HitMortalFieldGizmo) {
		super();
		this.fieldGizmo = fieldGizmo;
	}

	private static final WHITE:ArpColor = new ArpColor(0xffffffff);
	public function render(field:Field, context:RenderContext):Void {
		if (this.fieldGizmo.visible) {
			context.fillRect(0, 0, @:privateAccess field.hitField.size, 16, WHITE);
			for (mortal in field.mortals) {
				for (hitMortal in @:privateAccess mortal.hitMortals) {
					var x:Int = Math.round(hitMortal.hit.x);
					var y:Int = Math.round(hitMortal.hit.y);
					var sX:Int = Math.round(hitMortal.hit.sizeX);
					var sY:Int = Math.round(hitMortal.hit.sizeY);
					var color:ArpColor = fieldGizmo.hitColorFor(hitMortal);
					context.fillRect(x - sX, y - sY, 1, sY * 2, color);
					context.fillRect(x + sX, y - sY, 1, sY * 2, color);
					context.fillRect(x - sX, y - sY, sX * 2, 1, color);
					context.fillRect(x - sX, y + sY, sX * 2, 1, color);
				}
			}
		}
	}
}
