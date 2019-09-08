package arpx.hud;

import arpx.chip.Chip;
import arpx.impl.cross.hud.ChipMenuHudImpl;
import arpx.input.Input;
import arpx.menu.IMenuAxes;
import arpx.menu.Menu;
import arpx.structs.ArpPosition;

@:arpType("hud", "chipMenu")
class ChipMenuHud extends Hud implements IMenuAxes {

	@:arpBarrier @:arpField public var chip:Chip;
	@:arpField public var dPosition:ArpPosition;
	@:arpField public var axis:String = "y";
	@:arpField public var execute:String = "s";
	@:arpField public var abort:String = null;
	@:arpBarrier @:arpField public var menu:Menu;

	@:arpImpl private var arpImpl:ChipMenuHudImpl;

	public function new() super();

	override public function interact(input:Input):Bool return menu.interactWith(input, this);
}
