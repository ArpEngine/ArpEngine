package arpx.impl.heaps;

#if (arp_display_backend_heaps || arp_backend_display)

import hxd.App;

import arp.domain.ArpDomain;
import arpx.impl.cross.ArpEngineShellBase;
import arpx.impl.cross.display.DisplayContext;
import arpx.impl.cross.structs.ArpTransform;

class ArpEngineShell extends ArpEngineShellBase {

	private var app:ArpEngineApp;

	public function new(domain:ArpDomain, initParams:ArpEngineConfig) {
		super(domain, initParams);
		this.app = new ArpEngineApp(this);
	}

	override private function createDisplayContext():DisplayContext {
		return new DisplayContext(this.app.s2d, Math.ceil(this.width * this.scaleX), Math.ceil(this.height * this.scaleY), new ArpTransform().reset(this.scaleX, 0, 0, this.scaleY, 0, 0));
	}
}

private class ArpEngineApp extends App {

	private var shell:ArpEngineShell;

	public function new(shell:ArpEngineShell) {
		this.shell = shell;
		super();
	}

	override function init() @:privateAccess this.shell.onStart();
	override function update(dt:Float):Void @:privateAccess this.shell.domainRawTick(dt * 60);

	override public function render(e:h3d.Engine):Void {
		s3d.render(e);
		@:privateAccess this.shell.doRender(shell.displayContext);
		s2d.render(e);
	}
}
#end
