package arpx.automaton.procs;

import arpx.automaton.Automaton;
import arpx.proc.Proc;
import arpx.structs.ArpParams;

@:arpType("proc", "automaton.transition")
class ProcAutomatonTransition extends Proc {
	@:arpField public var automaton:Automaton;
	@:arpField public var transitionKey:String;
	@:arpField public var params:ArpParams;

	public function new() {
		super();
	}

	override public function execute():Void {
		automaton.transition(transitionKey, params);
	}
}
