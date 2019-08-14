package arpx.automaton;

import arp.domain.ArpDomain;
import arp.seed.ArpSeed;
import arpx.automaton.Automaton;
import arpx.automaton.events.AutomatonEventListener;
import arpx.state.AutomatonState;

import picotest.PicoAssert.*;

class AutomatonCase {

	private var domain:ArpDomain;
	private var me:Automaton;

	private var listener:AutomatonEventListener;
	private var events:Array<String>;

	private function parsedEvents():Array<String> {
		var result = events.copy();
		events.resize(0);
		return result;
	}

	private function describeEvent(e:AutomatonEvents):String {
		return switch (e) {
			case AutomatonEvents.EnterState(ev): ev.describe();
			case AutomatonEvents.LeaveState(ev): ev.describe();
			case AutomatonEvents.Transition(ev): ev.describe();
			case AutomatonEvents.Error(ev): ev.describe();
		}
	}

	public function setup():Void {
		domain = new ArpDomain();
		domain.addTemplate(Automaton);
		domain.addTemplate(AutomatonCallbackState, true);

		var seed:ArpSeed = ArpSeed.fromXml(DEFINITION);
		domain.loadSeed(seed);
		me = (domain.query("init", AutomatonState).value():AutomatonState).toAutomaton();
		me.arpSlot.addReference();

		listener = new AutomatonEventListener(me, false);
		events = AutomatonCallbackState.events = [];
		listener.onEvent.push(e -> events.push(describeEvent(e)));
	}

	private static var DEFINITION:Xml = Xml.parse('<data>
			<state name="init" label="init">
				<transition key="command" ref="state1" />
			</state>
			<state name="state1" label="state1">
				<transition key="command" ref="state2" />
				<transition key="command3" ref="state3" />
			</state>
			<state name="state2" label="state2">
				<transition key="command" ref="state1" />
				<transition key="command3" ref="state3" />
				<state ref="state2.a" />
			</state>
			<state name="state2.a" label="state2.a">
				<transition key="sub" ref="state2.b" />
			</state>
			<state name="state2.b" label="state2.b">
				<transition key="sub" ref="state2.a" />
			</state>
			<state name="state3" label="state3">
				<transition key="command" ref="state1" />
			</state>
		</data>');

	public function testAddEntry():Void {
		assertNotNull(domain.query("init", AutomatonState).value());
		assertNotNull(domain.query("state1", AutomatonState).value());
		assertNotNull(domain.query("state2", AutomatonState).value());
	}

	public function testAutomaton():Void {
		assertNotNull(me);
		assertNotNull(me.state);

		assertEquals(1, me.stateStack.length);
		assertEquals("init", me.state.label);

		me.transition("command", "params1");
		assertEquals(1, me.stateStack.length);
		assertEquals("state1", me.state.label);
		assertMatch([
			"Transition(command): init -> state1",
			"Leave(init): init",
			"Enter(state1): state1"
		], parsedEvents());

		me.transition("command", "params2");
		assertEquals(2, me.stateStack.length);
		assertEquals("state2", me.stateStack.getAt(0).label);
		assertEquals("state2.a", me.state.label);
		assertMatch([
			"Transition(command): state1 -> state2",
			"Leave(state1): state1",
			"Enter(state2): state2",
			"Enter(state2.a): state2, state2.a"
		], parsedEvents());

		me.transition("sub", "params3");
		assertEquals(2, me.stateStack.length);
		assertEquals("state2", me.stateStack.getAt(0).label);
		assertEquals("state2.b", me.state.label);
		assertMatch([
			"Transition(sub): state2.a -> state2.b",
			"Leave(state2.a): state2, state2.a",
			"Enter(state2.b): state2, state2.b"
		], parsedEvents());

		me.transition("sub", "params4");
		assertEquals(2, me.stateStack.length);
		assertEquals("state2", me.stateStack.getAt(0).label);
		assertEquals("state2.a", me.state.label);
		assertMatch([
			"Transition(sub): state2.b -> state2.a",
			"Leave(state2.b): state2, state2.b",
			"Enter(state2.a): state2, state2.a"
		], parsedEvents());

		me.transition("command", "params5");
		assertEquals(1, me.stateStack.length);
		assertEquals("state1", me.state.label);
		assertMatch([
			"Transition(command): state2 -> state1",
			"Leave(state2.a): state2, state2.a",
			"Leave(state2): state2",
			"Enter(state1): state1"
		], parsedEvents());

		me.transition("command3", "params6");
		assertEquals(1, me.stateStack.length);
		assertEquals("state3", me.state.label);
		assertMatch([
			"Transition(command3): state1 -> state3",
			"Leave(state1): state1",
			"Enter(state3): state3"
		], parsedEvents());

		me.transition("command3", "params7");
		assertEquals(1, me.stateStack.length);
		assertEquals("state3", me.state.label);
		assertMatch([
			"Error: state3 -> command3 -> No transition found"
		], parsedEvents());
	}

	public function testCallbacks():Void {
		var state0:AutomatonCallbackState = domain.query("init", AutomatonCallbackState).value();
		state0.record = true;
		var state1:AutomatonCallbackState = domain.query("state1", AutomatonCallbackState).value();
		state1.transitionInEnterState = "command";
		state1.record = true;
		var state2:AutomatonCallbackState = domain.query("state2", AutomatonCallbackState).value();
		state2.transitionInLeaveState = "command3";
		state2.record = true;
		var state3:AutomatonCallbackState = domain.query("state3", AutomatonCallbackState).value();
		state3.record = true;
		var state2a:AutomatonCallbackState = domain.query("state2.a", AutomatonCallbackState).value();
		state2a.record = true;

		me.transition("command");
		assertEquals(2, me.stateStack.length); // FIXME
		assertEquals("state2.a", me.state.label); // FIXME
		assertMatch([
			"Transition(command): init -> state1",
			"BeforeLeave(init): init",
			"AfterLeave(init): init",
			"Leave(init): init",
			"BeforeEnter(state1): state1",
			"Transition(command): state1 -> state2",
			"BeforeLeave(state1): state1",
			"AfterLeave(state1): state1",
			"Leave(state1): state1",
			"BeforeEnter(state2): state2",
			"AfterEnter(state2): state2",
			"Enter(state2): state2",
			"BeforeEnter(state2.a): state2, state2.a",
			"AfterEnter(state2.a): state2, state2.a",
			"Enter(state2.a): state2, state2.a",
			"AfterEnter(state1): state2, state2.a",
			"Enter(state1): state2, state2.a"
		], parsedEvents());
	}
}

@:arpType("state", "callback")
class AutomatonCallbackState extends AutomatonState {

	public static var events:Array<String> = [];

	@:arpField public var transitionInEnterState:String = null;
	@:arpField public var transitionInLeaveState:String = null;
	@:arpField public var record:Bool = false;

	public function new() super();

	private function recordEvent(name:String, automaton:Automaton):Void {
		if (!record) return;
		var stateStack:String = [for (state in automaton.stateStack) state.label].join(", ");
		events.push('$name(${label}): ${stateStack}');
	}

	override private function enterState(automaton:Automaton, payload:Dynamic = null):Void {
		recordEvent("BeforeEnter", automaton);
		if (transitionInEnterState != null) automaton.transition(transitionInEnterState);
		recordEvent("AfterEnter", automaton);
	}

	override private function leaveState(automaton:Automaton, payload:Dynamic = null):Void {
		recordEvent("BeforeLeave", automaton);
		if (transitionInLeaveState != null) automaton.transition(transitionInLeaveState);
		recordEvent("AfterLeave", automaton);
	}
}
