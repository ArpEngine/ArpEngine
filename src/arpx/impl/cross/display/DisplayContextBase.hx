package arpx.impl.cross.display;

import arpx.input.focus.IFocusTarget;
import arpx.impl.cross.structs.ArpTransform;

class DisplayContextBase {

	public var clearColor(default, null):UInt;

	public var transform(get, never):ArpTransform;
	private var transforms:ArpStructStack<ArpTransform>;

	inline private function get_transform():ArpTransform return this.transforms.head;
	inline public function dupTransform():ArpTransform return this.transforms.dup();
	inline public function popTransform():Void this.transforms.pop();

	public var focus(get, never):IFocusTarget;
	private var focuses:Array<IFocusTarget>;
	private function get_focus():IFocusTarget return this.focuses[this.focuses.length - 1];
	inline public function pushFocus(value:IFocusTarget):Void this.focuses.push(value);
	inline public function popFocus():IFocusTarget return this.focuses.pop();

	public function new(transform:ArpTransform = null, clearColor:UInt = 0xff000000) {
		this.transforms = new ArpStructStack();
		this.focuses = [null];
		if (transform != null) this.transform.copyFrom(transform);
		this.clearColor = clearColor;
	}
}
