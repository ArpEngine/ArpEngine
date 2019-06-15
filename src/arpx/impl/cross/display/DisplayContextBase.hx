package arpx.impl.cross.display;

import arpx.input.focus.IFocusTarget;
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

	public var focus(get, never):IFocusTarget;
	private var focuses:Array<IFocusTarget>;
	private function get_focus():IFocusTarget return this.focuses[this.focuses.length - 1];
	inline public function pushFocus(value:IFocusTarget):Void this.focuses.push(value);
	inline public function popFocus():IFocusTarget return this.focuses.pop();

	public function new(transform:ArpTransform = null, clearColor:UInt = 0xff000000) {
		this.transforms = [new ArpTransform()];
		this.focuses = [null];
		if (transform != null) this.transform.copyFrom(transform);
		this.clearColor = clearColor;
	}
}
