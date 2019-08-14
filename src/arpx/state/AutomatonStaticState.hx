package arpx.state;

import arpx.automaton.Automaton;
import arpx.screen.Screen;

@:arpType("state", "static")
class AutomatonStaticState extends AutomatonState {

	@:arpField public var automaton:Automaton;
	@:arpField public var screen:Screen;

	public function new() super();

	override private function enterState(automaton:Automaton, payload:Dynamic = null):Void {
		if (this.automaton != null) throw "this AutomatonStaticState is already active";
		this.automaton = automaton;
	}

	override private function leaveState(automaton:Automaton, payload:Dynamic = null):Void {
		this.automaton = null;
	}

	override public function toScreen():Screen return this.screen;

	public function transition(key:String, payload:Dynamic = null):Bool {
		if (this.automaton == null) return false;
		return @:privateAccess this.automaton.transition(key, payload);
	}
}
