package arpx;

import arpx.impl.cross.input.InputContext;
import arpx.impl.cross.audio.AudioContext;
import arp.domain.ArpDomain;
import arpx.impl.cross.display.DisplayContext;
import arpx.impl.cross.ArpEngineShell;

class ArpEngine {

	private var _domain:ArpDomain;
	public var domain(get, set):ArpDomain;
	private function get_domain():ArpDomain {
		return if (this.shell == null) this._domain else this.shell.domain;
	}
	private function set_domain(value:ArpDomain):ArpDomain {
		return if (this.shell == null) this._domain = value else this.shell.domain = value;
	}

	public var config(default, null):ArpEngineConfig;

	public var shell(default, null):ArpEngineShell;

	public var displayContext(get, never):DisplayContext;
	inline private function get_displayContext():DisplayContext return shell.displayContext;

	public var inputContext(get, never):InputContext;
	inline private function get_inputContext():InputContext return shell.inputContext;

	public var audioContext(get, never):AudioContext;
	inline private function get_audioContext():AudioContext return AudioContext.instance;

	public function new(domain:ArpDomain) {
		this._domain = domain;
		this.config = new ArpEngineConfig();
	}

	public function start():Void {
		var config = this.config;
		this.config = null;
		this.shell = new ArpEngineShell(this._domain, config);
	}
}
