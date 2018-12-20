package arpx.impl.cross.chip;

import arpx.chip.TileMapChip;
import arpx.impl.cross.display.RenderContext;
import arpx.impl.cross.geom.PointImpl;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.chip.IChipImpl;
import arpx.impl.cross.tilemap.TileMapBatchRenderer;
import arpx.structs.IArpParamsRead;

class TileMapChipImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:TileMapChip;
	private var renderer:TileMapBatchRenderer;

	public function new(chip:TileMapChip) {
		super();
		this.chip = chip;
		this.renderer = new TileMapBatchRenderer();
	}

	private var _workPt:PointImpl = PointImpl.alloc();
	public function render(context:RenderContext, params:IArpParamsRead = null):Void {
		this.renderer.reset(this.chip.tileMap, this.chip.chip);
		this.renderer.copyArea(context);
	}
}
