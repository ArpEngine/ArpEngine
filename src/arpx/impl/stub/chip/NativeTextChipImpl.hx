package arpx.impl.stub.chip;

#if (arp_display_backend_stub || arp_backend_display)

import arpx.structs.IArpParamsRead;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.chip.IChipImpl;
import arpx.impl.cross.display.RenderContext;
import arpx.chip.NativeTextChip;

class NativeTextChipImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:NativeTextChip;

	public function new(chip:NativeTextChip) {
		super();
		this.chip = chip;
	}

	public function render(context:RenderContext, params:IArpParamsRead = null):Void return;
}

#end
