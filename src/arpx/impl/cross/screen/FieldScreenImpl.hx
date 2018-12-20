package arpx.impl.cross.screen;

import arpx.impl.cross.display.RenderContext;
import arpx.impl.ArpObjectImplBase;
import arpx.screen.FieldScreen;

class FieldScreenImpl extends ArpObjectImplBase implements IScreenImpl {

	private var screen:FieldScreen;

	public function new(screen:FieldScreen) {
		super();
		this.screen = screen;
	}

	public function display(context:RenderContext):Void {
		if (this.screen.field == null) return;

		if (this.screen.camera != null) {
			context.dupTransform().prependTransform(this.screen.camera.composedCameraTransform);
		}

		if (this.screen.visible) this.screen.field.render(context);
		for (fieldGizmo in this.screen.fieldGizmos) fieldGizmo.render(this.screen.field, context);
		context.popTransform();
	}
}
