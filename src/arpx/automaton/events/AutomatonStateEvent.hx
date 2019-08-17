package arpx.automaton.events;

import arp.ds.IList;
import arpx.state.AutomatonState;

class AutomatonStateEvent extends AutomatonEvent<AutomatonStateEventKind> {

	public var state(default, null):AutomatonState;
	public var payload:Dynamic;

	public function new(kind:AutomatonStateEventKind, state:AutomatonState, stateStack:IList<AutomatonState>, payload:Dynamic) {
		super(kind, stateStack);
		this.state = state;
		this.payload = payload;
	}

	override public function describe():String {
		switch (this.kind) {
			case AutomatonStateEventKind.Enter:
				return 'Enter(${state.label}): ${stateStackLabels.join(", ")}';
			case AutomatonStateEventKind.Leave:
				return 'Leave(${state.label}): ${stateStackLabels.join(", ")}';
		}
	}
}

enum AutomatonStateEventKind {
	Enter;
	Leave;
}
