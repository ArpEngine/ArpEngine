package arpx.impl.cross.tilemap;

import arpx.chip.Chip;
import arpx.impl.cross.geom.PointImpl;
import arpx.impl.cross.geom.RectImpl;
import arpx.impl.cross.display.RenderContext;
import arpx.structs.ArpParams;
import arpx.tileMap.TileMap;

class TileMapBatchRenderer {

	private var chip:Chip;
	private var chipSize:RectImpl;
	private var tileMap:TileMap;

	public function new() {
		this.chipSize = RectImpl.alloc();
	}

	public function reset(tileMap:TileMap, chip:Chip) {
		this.tileMap = tileMap;
		this.chip = chip;
		this.chip.layoutSize(ArpParams.empty, this.chipSize);
	}

	private var gridLeft:Int;
	private var gridTop:Int;
	private var gridRight:Int;
	private var gridBottom:Int;

	private static var _workPt:PointImpl = PointImpl.alloc();
	private static var _workParams:ArpParams = new ArpParams();

	private function probePoint(context:RenderContext, x:Float, y:Float):Void {
		var pt:PointImpl = _workPt;
		pt.reset(x, y);
		context.transform.transformPoint(pt);
		var gridX:Int = Math.floor(pt.x / this.chipSize.width);
		var gridY:Int = Math.floor(pt.y / this.chipSize.height);
		if (gridX < gridLeft) gridLeft = gridX;
		if (gridY < gridTop) gridTop = gridY;
		if (gridX > gridRight) gridRight = gridX;
		if (gridY > gridBottom) gridBottom = gridY;
	}

	public function copyArea(context:RenderContext):Void {
		var params:ArpParams = _workParams;
		var chipWidth:Float = this.chipSize.width;
		var chipHeight:Float = this.chipSize.height;

		this.gridLeft = 0x7fffffff;
		this.gridTop = 0x7fffffff;
		this.gridRight = -(0x7fffffff);
		this.gridBottom = -(0x7fffffff);

		context.dupTransform();
		context.transform.invert();
		this.probePoint(context, 0, 0);
		this.probePoint(context, context.width, 0);
		this.probePoint(context, 0, context.height);
		this.probePoint(context, context.width, context.height);
		context.popTransform();

		gridRight++;
		gridBottom++;

		if (!this.tileMap.isInfinite) {
			var chipMapWidth:Int = this.tileMap.width;
			var chipMapHeight:Int = this.tileMap.height;
			if (gridLeft < 0) gridLeft = 0;
			if (gridTop < 0) gridTop = 0;
			if (gridRight > chipMapWidth) gridRight = chipMapWidth;
			if (gridBottom > chipMapHeight) gridBottom = chipMapHeight;
		}

		if (gridRight > gridLeft + 256) gridRight = gridLeft + 256;
		if (gridBottom > gridTop + 256) gridBottom = gridTop + 256;

		for (gridX in gridLeft...gridRight) {
			for (gridY in gridTop...gridBottom) {
				context.dupTransform();
				context.transform.prependXY(gridX * chipWidth, gridY * chipHeight);
				params.set("index", this.tileMap.getTileIndexAtGrid(gridX, gridY));
				this.chip.render(context, params);
				context.popTransform();
			}
		}
	}
}
