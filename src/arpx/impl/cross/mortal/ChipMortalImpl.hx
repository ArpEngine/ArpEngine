package arpx.impl.cross.mortal;

import arpx.impl.cross.display.RenderContext;
import arpx.impl.ArpObjectImplBase;
import arpx.mortal.ChipMortal;
import arpx.structs.ArpPosition;

class ChipMortalImpl extends ArpObjectImplBase implements IMortalImpl {

	private var mortal:ChipMortal;

	public function new(mortal:ChipMortal) {
		super();
		this.mortal = mortal;
	}

	public function render(context:RenderContext):Void {
		if (mortal.visible && mortal.chip != null) {
			var pos:ArpPosition = mortal.position;
			context.dupTransform().prependXY(pos.x, pos.y);
			// TODO mortal.params.dir = pos.dir;
			mortal.chip.render(context, mortal.params);
			context.popTransform();
		}
	}
}
