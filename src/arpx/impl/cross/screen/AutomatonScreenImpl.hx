package arpx.impl.cross.screen;

import arp.domain.ArpHeat;
import arp.ds.IList;
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
		var screens:IList<Screen> = @:privateAccess this.screen.screens;
		for (screen in screens) {
			if (screen != null && screen.arpHeat == ArpHeat.Warm) {
				screen.display(context);
			}
		}
	}
}
