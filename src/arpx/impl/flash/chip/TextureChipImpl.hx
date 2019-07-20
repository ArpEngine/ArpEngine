package arpx.impl.flash.chip;

#if (arp_display_backend_flash || arp_backend_display)

import arp.domain.ArpHeat;
import arpx.chip.TextureChip;
import arpx.impl.cross.chip.IChipImpl;
import arpx.impl.cross.display.RenderContext;
import arpx.impl.cross.structs.ArpTransform;
import arpx.impl.cross.texture.TextureFaceData;
import arpx.structs.IArpParamsRead;

class TextureChipImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:TextureChip;

	public function new(chip:TextureChip) {
		super();
		this.chip = chip;
	}

	public function render(context:RenderContext, params:IArpParamsRead = null):Void {
		if (this.chip.arpHeat < ArpHeat.Warm) {
			this.chip.arpDomain.log("gridchip", 'GridChip.copyChip(): Chip not warm: ${this}:$params');
			this.chip.arpHeatLater();
			return;
		}

		var faceInfo:TextureFaceData = this.chip.texture.getFaceData(params);
		if (faceInfo == null) return;

		var transform:ArpTransform = context.dupTransform();
		if (this.chip.baseX | this.chip.baseY != 0) {
			transform.prependXY(-this.chip.baseX, -this.chip.baseY);
		}
		context.fillFace(faceInfo, this.chip.color, this.chip.texture.hasAlpha, this.chip.texture.smoothing);
		context.popTransform();
	}
}

#end
