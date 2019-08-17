package arpx.automaton.events;

import arp.ds.IList;
import arp.ds.impl.ArrayList;
import arp.ds.lambda.ListOp;
import arpx.state.AutomatonState;

class AutomatonEvent<T> {

	public var kind(default, null):T;
	public var stateStack(default, null):IList<AutomatonState>;

	public var stateStackLabels(get, never):Array<String>;
	private function get_stateStackLabels():Array<String> {
		var list:ArrayList<String> = new ArrayList<String>();
		ListOp.map(this.stateStack, function(state:AutomatonState):String return state.label, list);
		return @:privateAccess list.value;
	}

	public function new(kind:T, stateStack:IList<AutomatonState>) {
		this.kind = kind;
		this.stateStack = ListOp.copy(stateStack, new ArrayList<AutomatonState>());
	}

	public function describe():String return null;
}

