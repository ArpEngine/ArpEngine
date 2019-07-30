package arpx.mortal;

import arp.ds.IList;
import arpx.field.Field;
import arpx.impl.cross.mortal.CompositeMortalImpl;
import arpx.mortal.Mortal;
import arpx.reactFrame.ReactFrame;
import arpx.structs.ArpParams;

@:arpType("mortal", "composite")
class CompositeMortal extends Mortal {

	@:arpField public var sort:String;
	@:arpField(true) @:arpBarrier public var mortals:IList<Mortal>;

	@:arpImpl private var arpImpl:CompositeMortalImpl;

	public function new() super();

	override private function get_isComplex():Bool return true;

	override public function tickChild(timeslice:Float, field:Field):Bool {
		super.tickChild(timeslice, field);
		for (mortal in this.mortals) {
			mortal.tickChild(timeslice, field);
		}
		return true;
	}

	override public function startAction(actionName:String, restart:Bool = false):Bool {
		var result:Bool = false;
		for (mortal in this.mortals) {
			result = mortal.startAction(actionName, restart) || result;
		}
		return result;
	}

	override public function react(field:Field, source:Mortal, reactFrame:ReactFrame, delay:Float):Void {
		for (mortal in this.mortals) {
			mortal.react(field, source, reactFrame, delay);
		}
	}

	override private function get_params():ArpParams {
		return new ArpParams();
	}

	override private function set_params(value:ArpParams):ArpParams {
		for (mortal in this.mortals) {
			mortal.params.copyFrom(value);
		}
		return value;
	}

}


