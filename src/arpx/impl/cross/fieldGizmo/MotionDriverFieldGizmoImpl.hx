package arpx.impl.cross.fieldGizmo;

import arpx.structs.ArpParams;
import arpx.driver.MotionDriver;
import arpx.field.Field;
import arpx.fieldGizmo.MotionDriverFieldGizmo;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.display.RenderContext;
import arpx.impl.cross.fieldGizmo.IFieldGizmoImpl;
import arpx.structs.ArpPosition;

class MotionDriverFieldGizmoImpl extends ArpObjectImplBase implements IFieldGizmoImpl {

	private var fieldGizmo:MotionDriverFieldGizmo;

	public function new(fieldGizmo:MotionDriverFieldGizmo) {
		super();
		this.fieldGizmo = fieldGizmo;
	}

	private static var _workParams:ArpParams = new ArpParams();
	public function render(field:Field, context:RenderContext):Void {
		if (!this.fieldGizmo.visible) return;

		for (mortal in field.mortals) {
			if (!Std.isOfType(mortal.driver, MotionDriver)) continue;
			var driver:MotionDriver = cast(mortal.driver, MotionDriver);
			var motionKey:String = driver.motionSet.motions.keyOf(driver.nowMotion);
			var motionTime:String = Std.string(Math.round(driver.nowTime));
			_workParams.set("face", '$motionKey\n$motionTime');
			var pos:ArpPosition = mortal.position;
			context.dupTransform().prependXY(pos.x, pos.y);
			context.tints.dup().applyMul(fieldGizmo.color);
			fieldGizmo.font.render(context, _workParams);
			context.tints.pop();
			context.popTransform();
		}
	}
}
