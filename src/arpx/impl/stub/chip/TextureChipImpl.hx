package arpx.impl.stub.chip;

#if (arp_display_backend_stub || arp_backend_display)

import arpx.structs.IArpParamsRead;
import arpx.chip.TextureChip;
import arpx.impl.cross.display.RenderContext;
import arpx.impl.cross.chip.IChipImpl;

class TextureChipImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:TextureChip;

	public function new(chip:TextureChip) {
		super();
		this.chip = chip;
	}

	public function render(context:RenderContext, params:IArpParamsRead = null):Void return;
}

#end
