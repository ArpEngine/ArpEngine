package arpx.impl.sys.texture;

#if (arp_display_backend_sys || arp_backend_display)

import arpx.impl.cross.texture.ITextureImpl;
import arpx.impl.cross.texture.TextureFaceData;
import arpx.impl.cross.texture.TextureImplBase;
import arpx.structs.IArpParamsRead;
import arpx.texture.ResourceTexture;

class ResourceTextureImpl extends TextureImplBase implements ITextureImpl {

	private var texture:ResourceTexture;

	public function new(texture:ResourceTexture) {
		super();
		this.texture = texture;
	}

	public function getFaceData(params:IArpParamsRead = null):TextureFaceData {
		return new TextureFaceDataImpl();
	}
}

#end
