package arpx.automaton.events;

import arp.ds.IList;
import arpx.state.AutomatonState;

class AutomatonStateEvent extends AutomatonEvent<AutomatonStateEventKind> {

	public var payload:Dynamic;

	public function new(kind:AutomatonStateEventKind, stateStack:IList<AutomatonState>, payload:Dynamic) {
		super(kind, stateStack);
		this.payload = payload;
	}

	override public function describe():String {
		switch (this.kind) {
			case AutomatonStateEventKind.Enter:
				return 'Enter: ${stateStackLabels.join(", ")}';
			case AutomatonStateEventKind.Leave:
				return 'Leave: ${stateStackLabels.join(", ")}';
		}
	}
}

enum AutomatonStateEventKind {
	Enter;
	Leave;
}
