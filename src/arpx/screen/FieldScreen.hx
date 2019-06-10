package arpx.screen;

import arpx.input.Input;
import arp.ds.IList;
import arpx.camera.Camera;
import arpx.field.Field;
import arpx.fieldGizmo.FieldGizmo;
import arpx.impl.cross.screen.FieldScreenImpl;

@:arpType("screen", "screen")
class FieldScreen extends Screen {
	@:arpField public var field:Field;
	@:arpBarrier @:arpField(true) public var fieldGizmos:IList<FieldGizmo>;
	@:arpField public var camera:Camera;

	@:arpImpl private var arpImpl:FieldScreenImpl;

	public function new() super();

	override public function tick(timeslice:Float):Bool {
		if (this.ticks) {
			return field.tick(timeslice);
		}
		return true;
	}

	override public function interact(input:Input):Bool return this.field.interact(input);

	override public function findFocus(other:Null<Screen>):Null<Screen> {
		return if (this.visible) this else other;
	}
}
