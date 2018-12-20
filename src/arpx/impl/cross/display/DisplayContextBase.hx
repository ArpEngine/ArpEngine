package arpx.impl.cross.display;

import arpx.impl.cross.structs.ArpTransform;

class DisplayContextBase {

	public var clearColor(default, null):UInt;

	public var transform(get, never):ArpTransform;
	private var transforms:Array<ArpTransform>;
	private var transformIndex:Int = 0;

	private function get_transform():ArpTransform return this.transforms[this.transformIndex];
	public function dupTransform():ArpTransform {
		var value:ArpTransform = this.transform;
		var transform:ArpTransform;
		if (++this.transformIndex < this.transforms.length) {
			transform = this.transform.copyFrom(value);
		} else {
			transform = value.clone();
			this.transforms.push(transform);
		}
		return transform;
	}
	public function popTransform():Void if (this.transformIndex > 0) this.transformIndex--;

	public function new(transform:ArpTransform = null, clearColor:UInt = 0xff000000) {
		this.transforms = [new ArpTransform()];
		if (transform != null) this.transform.copyFrom(transform);
		this.clearColor = clearColor;
	}
}
