package arpx.screen;

import arp.ds.IList;
import arpx.camera.Camera;
import arpx.field.Field;
import arpx.fieldGizmo.FieldGizmo;
import arpx.impl.cross.screen.FieldScreenImpl;
import arpx.input.Input;


@:arpType("screen", "screen")
class FieldScreen extends Screen {
	@:arpField public var field:Field;
	@:arpBarrier @:arpField(true) public var fieldGizmos:IList<FieldGizmo>;
	@:arpField public var camera:Camera;
	@:arpField public var input:Input;

	@:arpImpl private var arpImpl:FieldScreenImpl;

	public function new() super();

	override public function tick(timeslice:Float):Bool {
		if (ticks) field.tick(timeslice);
		return true;
	}

	override public function findFocus(other:Null<Input>):Null<Input> {
		return if (this.visible && this.input != null) this.input.findFocus(other) else other;
	}

	override public function updateFocus(target:Null<Input>):Void {
		if (this.visible && this.input != null) this.input.updateFocus(target);
	}
}
