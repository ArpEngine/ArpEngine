package arpx.impl.cross.texture.decorators;

import arpx.impl.cross.geom.RectImpl;
import arpx.impl.cross.texture.TextureImplBase;
import arpx.structs.IArpParamsRead;
import arpx.texture.decorators.MultiTexture;

class MultiTextureImplBase<T:MultiTexture> extends TextureImplBase {

	private var texture:T;

	private var indexesByFaces:Map<String, Int>;
	private var faces:Array<TextureFaceData>;

	public function new(texture:T) {
		super();
		this.texture = texture;
		this.indexesByFaces = new Map();
		this.faces = [];
	}

	override public function arpHeatDown():Bool {
		for (face in this.faces) face.dispose();
		this.faces = [];
		this.indexesByFaces = new Map();
		return true;
	}

	inline private function nextFaceName(face:String):Void {
		this.indexesByFaces[face] = this.faces.length;
	}

	inline private function pushFaceInfo(faceInfo:TextureFaceData):Void {
		this.faces.push(faceInfo);
	}

	override public function getFaceIndex(params:IArpParamsRead = null):Int {
		// face unset, use chip index = 0 as default
		if (params == null) return 0;

		var index:Int = 0;

		var face:String = params.getAsString("face");
		if (face != null) {
			if (this.indexesByFaces.exists(face)) {
				index = this.indexesByFaces.get(face);
			} else {
				this.texture.arpDomain.log("texture", 'MultiTextureImplBase.getFaceIndex(): Face name not found in: ${this.texture.arpSlot}:$params');
			}
		}

		index += texture.offset;
		var dIndex:Null<Int> = params.getInt("index");
		if (dIndex != null) index += dIndex;

		if (this.faces[index] == null) {
			this.texture.arpDomain.log("texture", 'MultiTextureImplBase.getFaceIndex(): Face index out of range: ${this.texture.arpSlot}:$index');
		}
		return index;
	}

	override public function widthOf(params:IArpParamsRead = null):Int return this.getFaceData(params).width;
	override public function heightOf(params:IArpParamsRead = null):Int return this.getFaceData(params).height;

	override public function layoutSize(params:IArpParamsRead, rect:RectImpl):RectImpl {
		rect.copyFrom(this.getFaceData(params).layoutSize);
		return rect;
	}

	public function getFaceData(params:IArpParamsRead = null):TextureFaceData {
		return this.faces[this.getFaceIndex(params)];
	}
}
