package arpx.impl.cross.display;

import haxe.Constraints.Constructible;

@:generic @:remove
class ArpStructStack<T:TArpStruct<T> & Constructible<()->Void>> {

	public function new() {
		this.stack = [new T()];
	}

	public var head(get, never):T;
	private var stack:Array<T>;
	private var index:Int = 0;

	private function get_head():T return this.stack[this.index];
	public function dup():T {
		var value:T = this.head;
		var transform:T;
		if (++this.index < this.stack.length) {
			transform = this.head.copyFrom(value);
		} else {
			transform = value.clone();
			this.stack.push(transform);
		}
		return transform;
	}
	public function pop():Void if (this.index > 0) this.index--;

}

private typedef TArpStruct<T> = {
	function copyFrom(value:T):T;
	function clone():T;
}
