package arpx.camera;

import arp.domain.IArpObject;
import arpx.impl.cross.structs.ArpTransform;
import arpx.structs.ArpPosition;

@:arpType("camera", "camera")
class Camera implements IArpObject {

	@:arpField public var position:ArpPosition;
	@:arpField public var transform:ArpTransform;

	private var _composedCameraTransform:ArpTransform = new ArpTransform();
	public var composedCameraTransform(get, never):ArpTransform;
	private function get_composedCameraTransform():ArpTransform {
		return _composedCameraTransform.copyFrom(this.transform).appendXY(-this.position.x, -this.position.y);
	}

	public function new() return;
}
