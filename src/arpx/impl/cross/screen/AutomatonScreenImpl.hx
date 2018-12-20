package arpx.impl.cross.screen;

import arpx.impl.cross.display.RenderContext;
import arpx.impl.ArpObjectImplBase;
import arpx.screen.AutomatonScreen;

class AutomatonScreenImpl extends ArpObjectImplBase implements IScreenImpl {

	private var screen:AutomatonScreen;

	public function new(screen:AutomatonScreen) {
		super();
		this.screen = screen;
	}

	public function display(context:RenderContext):Void {
		var c:IScreenImpl = @:privateAccess screen.screen;
		if (c != null) c.display(context);
	}
}
