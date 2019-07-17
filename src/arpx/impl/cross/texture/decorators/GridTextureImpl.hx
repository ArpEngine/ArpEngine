package arpx.impl.cross.texture.decorators;

import arpx.impl.cross.texture.decorators.MultiTextureImplBase;
import arpx.texture.decorators.GridTexture;

class GridTextureImpl extends MultiTextureImplBase<GridTexture> implements ITextureImpl {

	override private function get_width():Float return texture.width;
	override private function get_height():Float return texture.height;

	public function new(texture:GridTexture) {
		super(texture);
	}

	override public function arpHeatUpNow():Bool {
		super.arpHeatUpNow();

		if (this.faces.length > 0) return true;
		var faceInfo:TextureFaceData = this.texture.texture.getFaceData();
		var sourceWidth:Float = this.texture.texture.width;
		var sourceHeight:Float = this.texture.texture.height;

		var faceWidth:Float = this.texture.width;
		if (faceWidth == 0) faceWidth = sourceWidth;
		var faceHeight:Float = this.texture.height;
		if (faceHeight == 0) faceHeight = sourceHeight;

		var isVertical:Bool = this.texture.faceList.isVertical;
		var x:Float = 0;
		var y:Float = 0;
		for (face in this.texture.faceList) {
			this.nextFaceName(face);
			for (dir in 0...this.texture.dirs) {
				this.pushFaceInfo(faceInfo.trim(x, y, faceWidth, faceHeight));
				if (isVertical) {
					y += faceHeight;
					if (y >= sourceHeight) {
						y = 0;
						x += faceWidth;
					}
				} else {
					x += faceWidth;
					if (x >= sourceWidth) {
						x = 0;
						y += faceHeight;
					}
				}
			}
		}
		return true;
	}
}
