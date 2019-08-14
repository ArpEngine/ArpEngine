package arpx.state;

import arp.domain.IArpObject;
import arp.ds.IMap;
import arpx.automaton.Automaton;
import arpx.screen.Screen;

@:arpType("state", "state")
class AutomatonState implements IArpObject {

	@:arpField public var label:String;
	@:arpField("state") public var childState:AutomatonState;
	@:arpField("transitions", "transition") public var transitions:IMap<String, AutomatonState>;

	public function new() return;

	public function getTransition(key:String, payload:Dynamic = null):Null<AutomatonState> return this.transitions.get(key);

	private function enterState(automaton:Automaton, payload:Dynamic = null):Void return; // override me
	private function leaveState(automaton:Automaton, payload:Dynamic = null):Void return; // override me

	public function toAutomaton():Automaton {
		var automaton:Automaton = this.arpDomain.allocObject(Automaton);
		@:privateAccess automaton.enterState(this);
		return automaton;
	}

	public function toScreen():Screen return null;
}
