package arpx.impl.cross.mortal;

import arpx.impl.cross.display.RenderContext;
import arpx.impl.cross.geom.PointImpl;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.mortal.IMortalImpl;
import arpx.impl.cross.tilemap.TileMapBatchRenderer;
import arpx.mortal.TileMapMortal;

class TileMapMortalImpl extends ArpObjectImplBase implements IMortalImpl {

	private var mortal:TileMapMortal;
	private var renderer:TileMapBatchRenderer;

	public function new(mortal:TileMapMortal) {
		super();
		this.mortal = mortal;
		this.renderer = new TileMapBatchRenderer();
	}

	private var _workPt:PointImpl = PointImpl.alloc();
	public function render(context:RenderContext):Void {
		if (this.mortal.visible) {
			this.renderer.reset(this.mortal.tileMap, this.mortal.chip);
			this.renderer.copyArea(context);
		}
	}
}
