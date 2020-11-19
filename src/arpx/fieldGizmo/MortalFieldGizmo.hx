package arpx.fieldGizmo;

import arpx.chip.Chip;
import arpx.impl.cross.fieldGizmo.MortalFieldGizmoImpl;
import arpx.structs.ArpColor;
import arpx.structs.ArpPosition;

@:arpType("fieldGizmo", "mortal")
class MortalFieldGizmo extends FieldGizmo {

	@:arpField @:arpBarrier public var font:Chip;
	@:arpField public var color:ArpColor;
	@:arpField public var shift:ArpPosition;

	@:arpImpl private var arpImpl:MortalFieldGizmoImpl;

	public function new() super();
}
