package arpx.impl.cross.screen;

import arp.domain.ArpHeat;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.display.RenderContext;
import arpx.screen.AutomatonScreen;
import arpx.screen.Screen;

class AutomatonScreenImpl extends ArpObjectImplBase implements IScreenImpl {

	private var screen:AutomatonScreen;

	public function new(screen:AutomatonScreen) {
		super();
		this.screen = screen;
	}

	public function display(context:RenderContext):Void {
		var screen:Screen = @:privateAccess this.screen.screen;
		if (screen != null && screen.arpHeat == ArpHeat.Warm) {
			screen.display(context);
		}
	}
}
