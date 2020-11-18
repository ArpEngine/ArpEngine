package arpx.fieldGizmo;

import arpx.chip.Chip;
import arpx.impl.cross.fieldGizmo.MotionDriverFieldGizmoImpl;
import arpx.structs.ArpColor;

@:arpType("fieldGizmo", "motionDriver")
class MotionDriverFieldGizmo extends FieldGizmo {

	@:arpField @:arpBarrier public var font:Chip;
	@:arpField @:arpDefault("#ffffff@ff") public var color:ArpColor;

	@:arpImpl private var arpImpl:MotionDriverFieldGizmoImpl;

	public function new() super();
}
