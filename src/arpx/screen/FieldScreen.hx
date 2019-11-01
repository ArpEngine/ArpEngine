package arpx.screen;

import arp.ds.IList;
import arp.task.Heartbeat;
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

	@:arpImpl private var arpImpl:FieldScreenImpl;

	public function new() super();

	override public function tick(timeslice:Float):Heartbeat {
		if (this.ticks) {
			return field.tick(timeslice);
		}
		return Heartbeat.Keep;
	}

	override public function interact(input:Input):Bool return this.field.interact(input);
}
