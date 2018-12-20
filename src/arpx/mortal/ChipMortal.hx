package arpx.mortal;

import arpx.chip.Chip;
import arpx.impl.cross.mortal.ChipMortalImpl;

@:arpType("mortal", "chip")
class ChipMortal extends Mortal {

	@:arpBarrier @:arpField public var chip:Chip;

	@:arpImpl private var arpImpl:ChipMortalImpl;

	public function new() super();

	override public function startAction(actionName:String, restart:Bool = false):Bool {
		this.params.set("face", actionName);
		return true;
	}

}


