package arpx.impl.cross.display;

import arpx.impl.cross.display.stack.ArpColorStack;
import arpx.impl.cross.display.stack.ArpTransformStack;
import arpx.impl.cross.structs.ArpTransform;
import arpx.input.focus.IFocusTarget;
import arpx.structs.ArpColor;

class DisplayContextBase {

	public var clearColor(default, null):UInt;

	public var transform(get, never):ArpTransform;
	private var transforms:ArpTransformStack;

	inline private function get_transform():ArpTransform return this.transforms.head;
	inline public function dupTransform():ArpTransform return this.transforms.dup();
	inline public function popTransform():Void this.transforms.pop();

	public var tint(get, never):ArpColor;
	inline private function get_tint():ArpColor return this.tints.head;
	public var tints(get, never):ArpColorStack;
	inline private function get_tints():ArpColorStack return this.color("tint");

	public function color(key:String):ArpColorStack {
		if (colors.exists(key)) return colors.get(key);
		var result = new ArpColorStack();
		colors.set(key, result);
		return result;
	}
	private var colors:Map<String, ArpColorStack>;

	public var focus(get, never):IFocusTarget;
	private var focuses:Array<IFocusTarget>;
	private function get_focus():IFocusTarget return this.focuses[this.focuses.length - 1];
	inline public function pushFocus(value:IFocusTarget):Void this.focuses.push(value);
	inline public function popFocus():IFocusTarget return this.focuses.pop();

	public function new(transform:ArpTransform = null, clearColor:UInt = 0xff000000) {
		this.transforms = new ArpTransformStack();
		this.colors = new Map<String, ArpColorStack>();
		this.focuses = [null];
		if (transform != null) this.transform.copyFrom(transform);
		this.clearColor = clearColor;
	}
}
