package arpx.fieldGizmo;

import arpx.chip.Chip;
import arpx.impl.cross.fieldGizmo.MotionDriverFieldGizmoImpl;
import arpx.structs.ArpColor;
import arpx.structs.ArpPosition;

@:arpType("fieldGizmo", "motionDriver")
class MotionDriverFieldGizmo extends FieldGizmo {

	@:arpField @:arpBarrier public var font:Chip;
	@:arpField public var color:ArpColor;
	@:arpField public var shift:ArpPosition;

	@:arpImpl private var arpImpl:MotionDriverFieldGizmoImpl;

	public function new() super();
}
