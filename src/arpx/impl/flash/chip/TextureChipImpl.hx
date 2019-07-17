package arpx.impl.flash.chip;

#if (arp_display_backend_flash || arp_backend_display)

import flash.display.BlendMode;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import arp.domain.ArpHeat;
import arpx.chip.TextureChip;
import arpx.impl.cross.chip.IChipImpl;
import arpx.impl.cross.display.RenderContext;
import arpx.impl.cross.geom.PointImpl;
import arpx.impl.cross.structs.ArpTransform;
import arpx.impl.cross.texture.TextureFaceData;
import arpx.structs.IArpParamsRead;

class TextureChipImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:TextureChip;

	public function new(chip:TextureChip) {
		super();
		this.chip = chip;
	}

	private var _workPt:PointImpl = PointImpl.alloc();
	private var _workRect:Rectangle = new Rectangle();
	private var _workMatrix:Matrix = new Matrix();
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
		var pt:PointImpl = transform.asPoint(_workPt);
		if (pt != null && this.chip.color == null) {
			context.bitmapData.copyPixels(faceInfo.source, faceInfo.bound, pt.raw, null, null, this.chip.texture.hasAlpha);
		} else {
			var colorTransform:ColorTransform = this.chip.color.toMultiplier();
			context.bitmapData.draw(faceInfo.trimmed, transform.impl.raw, colorTransform, BlendMode.NORMAL, null, this.chip.texture.smoothing);
		}
		context.popTransform();
	}
}

#end
