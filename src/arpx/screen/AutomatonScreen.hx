package arpx.screen;

import arp.ds.IList;
import arpx.automaton.Automaton;
import arpx.automaton.events.AutomatonStateEvent;
import arpx.impl.cross.screen.AutomatonScreenImpl;
import arpx.input.Input;
import arpx.state.AutomatonState;

@:arpType("screen", "automaton")
class AutomatonScreen extends Screen {

	@:arpBarrier @:arpField public var automaton:Automaton;
	@:arpField(false) private var screens:IList<Screen>;

	@:arpImpl private var arpImpl:AutomatonScreenImpl;

	public function new() super();

	private function pushStateScreen(state:AutomatonState):Void {
		var screen:Screen = state.toScreen();
		this.screens.push(screen);
		if (screen != null) screen.arpHeatLater();
	}

	@:arpHeatUp private function heatUp():Bool {
		for (state in this.automaton.stateStack) this.pushStateScreen(state);
		this.automaton.onEnterState.push(this.onEnterState);
		this.automaton.onLeaveState.push(this.onLeaveState);
		return true;
	}

	@:arpHeatDown private function heatDown():Bool {
		this.screens.clear();
		this.automaton.onEnterState.remove(this.onEnterState);
		this.automaton.onLeaveState.remove(this.onLeaveState);
		return true;
	}

	private function onEnterState(v:AutomatonStateEvent):Void {
		this.pushStateScreen(v.state);
	}

	private function onLeaveState(v:AutomatonStateEvent):Void {
		this.screens.pop();
	}

	override public function tick(timeslice:Float):Bool {
		if (this.ticks) {
			pushStack();
			for (screen in this.screens) if (screen != null) screen.tick(timeslice);
			var v:TransitionData = popStack();
			if (v != null) return this.automaton.transition(v.key, v.payload);
		}
		return true;
	}

	override public function interact(input:Input):Bool {
		var b:Bool = false;
		for (screen in this.screens) if (screen != null) b = screen.interact(input) || b;
		return b;
	}

	override public function collectInputLayers(layers:Array<Screen>):Void {
		if (!this.visible) return;
		if (this.priority != 0) {
			layers.push(this);
		} else {
			for (screen in this.screens) if (screen != null) screen.collectInputLayers(layers);
		}
	}

	private static var _transitionStack:TransitionStack;
	private static var transitionStack(get, never):TransitionStack;
	private static function get_transitionStack():TransitionStack {
		if (_transitionStack == null) _transitionStack = new TransitionStack();
		return _transitionStack;
	}

	private static function pushStack():Void transitionStack.stack.push(null);
	private static function popStack():TransitionData return transitionStack.stack.pop();

	public static function transition(key:String, payload:Dynamic = null):Void {
		var lastIndex:Int = transitionStack.stack.length - 1;
		if (lastIndex < 0) throw "invalid state";
		if (transitionStack.stack[lastIndex] != null) throw "attempt to transition twice";
		transitionStack.stack[lastIndex] = new TransitionData(key, payload);
	}
}

class TransitionStack {
	public var stack(default, null):Array<TransitionData>;
	public function new() stack = [];
}

class TransitionData {
	public var key:String;
	public var payload:Dynamic;
	public function new(key:String, payload:Dynamic) {
		this.key = key;
		this.payload = payload;
	}
}
