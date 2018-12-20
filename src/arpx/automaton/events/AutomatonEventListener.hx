package arpx.automaton.events;

import arp.events.ArpSignal;
import arp.events.IArpSignalOut;

class AutomatonEventListener {

	private var automaton:Automaton;
	private var verbose:Bool;

	private var _onEvent:ArpSignal<AutomatonEvents>;
	public var onEvent(get, never):IArpSignalOut<AutomatonEvents>;
	private function get_onEvent():IArpSignalOut<AutomatonEvents> return this._onEvent;

	public function new(automaton:Automaton, verbose:Bool) {
		this._onEvent = new ArpSignal<AutomatonEvents>();
		this.automaton = automaton;
		this.automaton.onEnterState.push(this.onEnterState);
		this.automaton.onLeaveState.push(this.onLeaveState);
		this.automaton.onTransition.push(this.onTransition);
		this.automaton.onError.push(this.onError);
		this.verbose = verbose;
	}

	private function onEnterState(event:AutomatonStateEvent):Void {
		if (this.verbose) this.automaton.arpDomain.log("automaton", event.describe());
		this._onEvent.dispatch(AutomatonEvents.EnterState(event));
	}

	private function onLeaveState(event:AutomatonStateEvent):Void {
		if (this.verbose) this.automaton.arpDomain.log("automaton", event.describe());
		this._onEvent.dispatch(AutomatonEvents.LeaveState(event));
	}

	private function onTransition(event:AutomatonTransitionEvent):Void {
		if (this.verbose) this.automaton.arpDomain.log("automaton", event.describe());
		this._onEvent.dispatch(AutomatonEvents.Transition(event));
	}

	private function onError(event:AutomatonErrorEvent):Void {
		if (this.verbose) this.automaton.arpDomain.log("automaton", event.describe());
		this._onEvent.dispatch(AutomatonEvents.Error(event));
	}

	public function dispose():Void {
		this.automaton.onEnterState.remove(this.onEnterState);
		this.automaton.onLeaveState.remove(this.onLeaveState);
		this.automaton.onTransition.remove(this.onTransition);
		this.automaton.onError.remove(this.onError);
		this.automaton = null;
	}
}

enum AutomatonEvents {
	EnterState(event:AutomatonStateEvent);
	LeaveState(event:AutomatonStateEvent);
	Transition(event:AutomatonTransitionEvent);
	Error(event:AutomatonErrorEvent);
}
