package arpx.automaton.events;

import arp.ds.IList;
import arpx.state.AutomatonState;

class AutomatonErrorEvent extends AutomatonEvent<AutomatonErrorEventKind> {

	public var key:String;
	public var payload:Dynamic;

	public function new(kind:AutomatonErrorEventKind, stateStack:IList<AutomatonState>, key:String, payload:Dynamic) {
		super(kind, stateStack);
		this.key = key;
		this.payload = payload;
	}

	override public function describe():String {
		switch (this.kind) {
			case AutomatonErrorEventKind.Conflict:
				return 'Error(${key}): Cannot transition inside transition';
			case AutomatonErrorEventKind.Inactive:
				return 'Error(${key}): Automaton is not active';
			case AutomatonErrorEventKind.TransitionNotFound:
				return 'Error(${key}): No transition found: ${stateStackLabels.join(", ")}';
		}
	}
}

enum AutomatonErrorEventKind {
	Conflict;
	Inactive;
	TransitionNotFound;
}
