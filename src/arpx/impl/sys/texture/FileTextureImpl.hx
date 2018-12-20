package arpx.impl.sys.texture;

#if (arp_display_backend_sys || arp_backend_display)

import arpx.impl.cross.texture.ITextureImpl;
import arpx.impl.cross.texture.TextureImplBase;
import arpx.structs.IArpParamsRead;
import arpx.texture.FileTexture;

class FileTextureImpl extends TextureImplBase implements ITextureImpl {

	private var texture:FileTexture;

	public function new(texture:FileTexture) {
		super();
		this.texture = texture;
	}

	public function getFaceData(params:IArpParamsRead = null):TextureFaceData {
		return new TextureFaceData();
	}
}

#end
