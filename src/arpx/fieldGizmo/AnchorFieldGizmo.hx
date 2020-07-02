package arpx.fieldGizmo;

import arp.ds.IMap;
import arpx.anchor.Anchor;
import arpx.impl.cross.fieldGizmo.AnchorFieldGizmoImpl;
import arpx.structs.ArpColor;

@:arpType("fieldGizmo", "anchor")
class AnchorFieldGizmo extends FieldGizmo {

	@:arpField @:arpDefault("#cccccc") public var hitColor:ArpColor;

	@:arpField public var hitType:IMap<String, ArpColor>;

	@:arpImpl private var arpImpl:AnchorFieldGizmoImpl;

	public function new() super();

	public function hitColorFor(anchor:Anchor):ArpColor {
		return if (hitType.hasKey(anchor.hitFrame.hitType)) hitType.get(anchor.hitFrame.hitType) else hitColor;
	}
}
