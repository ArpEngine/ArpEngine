package arpx.impl.sys;

#if (arp_display_backend_sys || arp_backend_display)

import arp.domain.ArpDomain;
import arpx.impl.cross.ArpEngineShellBase;
import arpx.impl.cross.display.DisplayContext;
import arpx.impl.cross.structs.ArpTransform;

class ArpEngineShell extends ArpEngineShellBase {

	public function new(domain:ArpDomain, config:ArpEngineConfig) super(domain, config);

	override private function createDisplayContext():DisplayContext {
		return new DisplayContext(this.width, this.height, new ArpTransform(), new ArpColor(this.clearColor));
	}
}

#end
