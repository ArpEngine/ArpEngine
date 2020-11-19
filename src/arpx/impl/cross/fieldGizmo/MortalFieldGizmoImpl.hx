package arpx.impl.cross.fieldGizmo;

import arpx.field.Field;
import arpx.fieldGizmo.MortalFieldGizmo;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.display.RenderContext;
import arpx.impl.cross.fieldGizmo.IFieldGizmoImpl;
import arpx.mortal.Mortal;
import arpx.structs.ArpParams;
import arpx.structs.ArpPosition;

class MortalFieldGizmoImpl extends ArpObjectImplBase implements IFieldGizmoImpl {

	private var fieldGizmo:MortalFieldGizmo;

	public function new(fieldGizmo:MortalFieldGizmo) {
		super();
		this.fieldGizmo = fieldGizmo;
	}

	private static var _workParams:ArpParams = new ArpParams();
	public function render(field:Field, context:RenderContext):Void {
		if (!this.fieldGizmo.visible) return;

		for (kv in field.mortals.keyValueIterator()) {
			var key:String = kv.key;
			var mortal:Mortal = kv.value;
			var face:String = mortal.params.getAsString("face");
			_workParams.set("face", '$key\n$face');
			var pos:ArpPosition = mortal.position;
			var shift:ArpPosition = this.fieldGizmo.shift;
			context.dupTransform().prependXY(pos.x, pos.y).prependXY(shift.x, shift.y);
			context.tints.dup().applyMul(fieldGizmo.color);
			this.fieldGizmo.font.render(context, _workParams);
			context.tints.pop();
			context.popTransform();
		}
	}
}
