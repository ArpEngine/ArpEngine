package arpx.impl.cross.screen;

import arpx.impl.cross.display.RenderContext;
import arpx.impl.cross.structs.ArpTransform;
import arpx.impl.ArpObjectImplBase;
import arpx.screen.HudScreen;
import arpx.structs.ArpPosition;

class HudScreenImpl extends ArpObjectImplBase implements IScreenImpl {

	private var screen:HudScreen;

	public function new(screen:HudScreen) {
		super();
		this.screen = screen;
	}

	private static var _workPos:ArpPosition = new ArpPosition();

	public function display(context:RenderContext):Void {
		if (!this.screen.visible) return;

		if (this.screen.camera != null) {
			context.dupTransform().prependTransform(this.screen.camera.composedCameraTransform);
		}

		for (hud in this.screen.huds) hud.render(context);
		context.popTransform();
	}
}
