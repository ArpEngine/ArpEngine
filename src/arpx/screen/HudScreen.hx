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
			var other:Null<Hud> = this.focus;
			if (other == null) {
				for (hud in this.huds) other = hud.findFocus(other);
				this.focus = other;
			}
			if (other != null) return other.interact(input);
		}
		return false;
	}

	override public function findFocus(other:Null<Screen>):Null<Screen> {
		return if (this.visible) this else other;
	}
}
