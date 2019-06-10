package arpx.hud;

import arp.ds.IList;
import arpx.impl.cross.hud.CompositeHudImpl;

@:arpType("hud", "composite")
class CompositeHud extends Hud {

	@:arpField public var sort:String;
	@:arpField(true) @:arpBarrier public var huds:IList<Hud>;

	@:arpImpl private var arpImpl:CompositeHudImpl;

	public function new() super();

	override public function findFocus(other:Null<Hud>):Null<Hud> {
		if (this.visible) for (hud in this.huds) other = hud.findFocus(other);
		return other;
	}
}


