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

	public function setup():Void {
		var seed:ArpSeed = ArpSeed.fromXml(DEFINITION);
		domain = new ArpDomain();
		domain.addTemplate(Automaton);
		domain.addTemplate(AutomatonState);
		domain.loadSeed(seed);
		me = (domain.query("init", AutomatonState).value():AutomatonState).toAutomaton();
		me.arpSlot.addReference();
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
		var listener:AutomatonEventListener = new AutomatonEventListener(me, false);
		var events:Array<AutomatonEvents> = [];
		listener.onEvent.push(function(en:AutomatonEvents) events.push(en));

		function parsedEvents():Array<String> {
			var result = events.map(function(en:AutomatonEvents):String {
				return switch (en) {
					case AutomatonEvents.EnterState(ev): ev.describe();
					case AutomatonEvents.LeaveState(ev): ev.describe();
					case AutomatonEvents.Transition(ev): ev.describe();
					case AutomatonEvents.Error(ev): ev.describe();
				}
			});
			events = [];
			return result;
		}
		assertNotNull(me);
		assertNotNull(me.state);

		assertEquals(1, me.stateStack.length);
		assertEquals("init", me.state.label);

		me.transition("command", "params1");
		assertEquals(1, me.stateStack.length);
		assertEquals("state1", me.state.label);
		assertMatch([
			"Transition: init -> command -> state1",
			"Leave: init",
			"Enter: state1"
		], parsedEvents());

		me.transition("command", "params2");
		assertEquals(2, me.stateStack.length);
		assertEquals("state2", me.stateStack.getAt(0).label);
		assertEquals("state2.a", me.state.label);
		assertMatch([
			"Transition: state1 -> command -> state2",
			"Leave: state1",
			"Enter: state2",
			"Enter: state2, state2.a"
		], parsedEvents());

		me.transition("sub", "params3");
		assertEquals(2, me.stateStack.length);
		assertEquals("state2", me.stateStack.getAt(0).label);
		assertEquals("state2.b", me.state.label);
		assertMatch([
			"Transition: state2.a -> sub -> state2.b",
			"Leave: state2, state2.a",
			"Enter: state2, state2.b"
		], parsedEvents());

		me.transition("sub", "params4");
		assertEquals(2, me.stateStack.length);
		assertEquals("state2", me.stateStack.getAt(0).label);
		assertEquals("state2.a", me.state.label);
		assertMatch([
			"Transition: state2.b -> sub -> state2.a",
			"Leave: state2, state2.b",
			"Enter: state2, state2.a"
		], parsedEvents());

		me.transition("command", "params5");
		assertEquals(1, me.stateStack.length);
		assertEquals("state1", me.state.label);
		assertMatch([
			"Transition: state2 -> command -> state1",
			"Leave: state2, state2.a",
			"Leave: state2",
			"Enter: state1"
		], parsedEvents());

		me.transition("command3", "params6");
		assertEquals(1, me.stateStack.length);
		assertEquals("state3", me.state.label);
		assertMatch([
			"Transition: state1 -> command3 -> state3",
			"Leave: state1",
			"Enter: state3"
		], parsedEvents());

		me.transition("command3", "params7");
		assertEquals(1, me.stateStack.length);
		assertEquals("state3", me.state.label);
		assertMatch([
			"Error: state3 -> command3 -> No transition found"
		], parsedEvents());
	}
}


