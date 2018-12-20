package arpx.impl.cross.hud;

import arpx.impl.cross.display.RenderContext;
import arpx.hud.CompositeHud;
import arpx.impl.ArpObjectImplBase;
import arpx.structs.ArpPosition;

class CompositeHudImpl extends ArpObjectImplBase implements IHudImpl {

	private var hud:CompositeHud;

	public function new(hud:CompositeHud) {
		super();
		this.hud = hud;
	}

	public function render(context:RenderContext):Void {
		if (hud.visible) {
			var pos:ArpPosition = hud.position;
			context.dupTransform().prependXY(pos.x, pos.y);
			for (h in hud.huds) h.render(context);
			context.popTransform();
		}
	}
}
