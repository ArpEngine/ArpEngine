package arpx.impl.cross.display.stack;

@:generic @:remove
class ArpStructStack<T> {

	public function new() {
		this.stack = [this.create()];
	}

	public var head(get, never):T;
	private var stack:Array<T>;
	private var index:Int = 0;

	private function get_head():T return this.stack[this.index];
	public function dup():T {
		var value:T = this.head;
		var instance:T;
		if (++this.index < this.stack.length) {
			instance = this.copyFrom(this.head, value);
		} else {
			instance = this.clone(value);
			this.stack.push(instance);
		}
		return instance;
	}
	public function pop():Void if (this.index > 0) this.index--;

	private function create():T throw "Not implemented";
	private function copyFrom(me:T, value:T):T throw "Not implemented";
	private function clone(me:T):T throw "Not implemented";
}
