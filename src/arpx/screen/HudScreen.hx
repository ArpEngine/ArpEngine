package arpx.screen;

import arp.ds.IList;
import arpx.camera.Camera;
import arpx.hud.Hud;
import arpx.impl.cross.screen.HudScreenImpl;
import arpx.input.Input;

@:arpType("screen", "hud")
class HudScreen extends Screen {
	@:arpBarrier @:arpField(true) public var huds:IList<Hud>;
	@:arpField public var camera:Camera;
	@:arpField public var focus:Hud;

	@:arpImpl private var arpImpl:HudScreenImpl;

	public function new() super();

	override public function interact(input:Input):Bool {
		if (this.visible) {
			if (this.focus != null) return this.focus.interact(input);
		}
		return false;
	}
}
