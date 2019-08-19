package arpx.impl.heaps.texture;

#if (arp_display_backend_heaps || arp_backend_display)

import h2d.Tile;
import h3d.mat.Data;
import hxd.fs.BytesFileSystem.BytesFileEntry;
import hxd.fs.FileEntry;
import hxd.res.Image;

import arpx.impl.cross.texture.ITextureImpl;
import arpx.impl.cross.texture.TextureFaceData;
import arpx.impl.cross.texture.TextureImplBase;
import arpx.structs.IArpParamsRead;
import arpx.texture.FileTexture;

class FileTextureImpl extends TextureImplBase implements ITextureImpl {

	private var texture:FileTexture;
	private var value:Tile;
	private var impl:TextureFaceDataImpl;

	override private function get_width():Float return this.value.width;
	override private function get_height():Float return this.value.height;

	public function new(texture:FileTexture) {
		super();
		this.texture = texture;
	}

	override public function arpHeatUpNow():Bool {
		if (this.value != null) return true;

		var fileEntry:FileEntry = new BytesFileEntry("", texture.file.bytes());
		// 	this.texture.arpDomain.waitFor(this.texture);
		// 	return false;
		// }

		// private function onLoadComplete(image:Image):Void {
		this.value = new Image(fileEntry).toTile();
		this.value.getTexture().filter = if (texture.smoothing) Filter.Linear else Filter.Nearest;
		this.impl = new TextureFaceDataImpl(this.value);
		// this.texture.arpDomain.notifyFor(this.texture);
		return true;
	}

	override public function arpHeatDownNow():Bool {
		this.value = null;
		this.impl = null;
		return true;
	}

	public function getFaceData(params:IArpParamsRead = null):TextureFaceData {
		return this.impl;
	}
}

#end
