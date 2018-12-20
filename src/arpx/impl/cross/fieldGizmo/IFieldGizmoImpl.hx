package arpx.impl.cross.fieldGizmo;

import arp.impl.IArpObjectImpl;
import arpx.impl.cross.display.RenderContext;
import arpx.field.Field;

interface IFieldGizmoImpl extends IArpObjectImpl {
	function render(field:Field, context:RenderContext):Void;
}
