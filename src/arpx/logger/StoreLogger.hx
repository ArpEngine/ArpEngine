package arpx.logger;

import arp.domain.events.ArpLogEvent;

@:arpType("logger", "store")
class StoreLogger extends Logger {

	public function new() {
		super();
	}

	private var _store:Map<String, Array<String>>;
	public var store(get, never):Map<String, Array<String>>;
	private function get_store():Map<String, Array<String>> {
		if (this._store == null) this._store = new Map<String, Array<String>>();
		return this._store;
	}

	override public function log(event:ArpLogEvent):Void {
		if (!this.respondsTo(event.category)) return;

		var array:Array<String> = this.store.get(event.category);
		if (array == null) {
			array = [];
			this.store.set(event.category, array);
		}
		array.push(event.message);
	}

	public function dump(category:String):Array<String> {
		var result:Array<String> = this.store.get(category);
		if (result == null) {
			result = [];
		} else {
			this.store.remove(category);
		}
		return result;
	}
}


