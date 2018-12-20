package arpx.fieldGizmo;

import arp.domain.IArpObject;
import arpx.impl.cross.fieldGizmo.IFieldGizmoImpl;

@:arpType("fieldGizmo")
class FieldGizmo implements IArpObject implements IFieldGizmoImpl {

	@:arpField public var visible:Bool = true;

	@:arpImpl private var arpImpl:IFieldGizmoImpl;

	public function new() return;
}
