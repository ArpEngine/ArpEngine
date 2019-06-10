package arpx.impl.cross.hud;

import arpx.hud.ChipMenuHud;
import arpx.impl.cross.display.RenderContext;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.hud.IHudImpl;
import arpx.impl.cross.structs.ArpTransform;
import arpx.menu.Menu;
import arpx.structs.ArpParams;
import arpx.structs.ArpPosition;

class ChipMenuHudImpl extends ArpObjectImplBase implements IHudImpl {

	private var hud:ChipMenuHud;

	public function new(hud:ChipMenuHud) {
		super();
		this.hud = hud;
	}

	public function render(context:RenderContext):Void {
		if (hud.visible && hud.chip != null) {
			hud.focused = hud == context.focus;
			var menu:Menu = hud.menu;
			var pos:ArpPosition = hud.position;
			var dPos:ArpPosition = hud.dPosition;
			var transform:ArpTransform = context.dupTransform().prependXY(pos.x, pos.y);
			var param:ArpParams = new ArpParams();
			var index:Int = 0;
			for (item in menu.menuItems) {
				param.set("face", item.text.publish(param));
				param.set("selected", index == hud.menu.value);
				param.set("index", index++);
				hud.chip.render(context, param);
				transform.prependXY(dPos.x, dPos.y);
			}
			context.popTransform();
		}
	}
}
