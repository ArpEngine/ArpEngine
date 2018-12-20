package arpx.socketClient;

import haxe.io.Bytes;
import arp.domain.IArpObject;
import arp.events.ArpProgressEvent;
import arp.events.ArpSignal;
import arp.events.IArpSignalOut;
import arpx.impl.cross.socketClient.ISocketClientImpl;

@:arpType("socketClient", "null")
class SocketClient implements IArpObject implements ISocketClientImpl {

	@:arpImpl private var arpImpl:ISocketClientImpl;

	private var _onData:ArpSignal<ArpProgressEvent>;
	public var onData(get, never):IArpSignalOut<ArpProgressEvent>;
	private function get_onData():IArpSignalOut<ArpProgressEvent> return this._onData;

	private var _onClose:ArpSignal<Any>;
	public var onClose(get, never):IArpSignalOut<Any>;
	private function get_onClose():IArpSignalOut<Any> return this._onClose;

	public function new() {
		this._onData = new ArpSignal<ArpProgressEvent>();
		this._onClose = new ArpSignal<Any>();
	}

	// we have to implement them manually because function default values are lost in TypedExpr world

	public var bigEndian(get, set):Bool;
	private function get_bigEndian():Bool return this.arpImpl.bigEndian;
	private function set_bigEndian(value:Bool):Bool return this.arpImpl.bigEndian = value;

	inline public function readBool():Bool return arpImpl.readBool();
	inline public function readInt8():Int return arpImpl.readInt8();
	inline public function readInt16():Int return arpImpl.readInt16();
	inline public function readInt32():Int return arpImpl.readInt32();
	inline public function readUInt8():UInt return arpImpl.readUInt8();
	inline public function readUInt16():UInt return arpImpl.readUInt16();
	inline public function readUInt32():UInt return arpImpl.readUInt32();
	inline public function readFloat():Float return arpImpl.readFloat();
	inline public function readDouble():Float return arpImpl.readDouble();
	inline public function readBytes(bytes:Bytes, offset:UInt = 0, length:UInt = 0):Void return arpImpl.readBytes(bytes, offset, length);
	inline public function readUtfBytes(length:UInt):String return arpImpl.readUtfBytes(length);
	inline public function readBlob():Bytes return arpImpl.readBlob();
	inline public function readUtfBlob():String return arpImpl.readUtfBlob();
	inline public function readUtfString():Null<String> return arpImpl.readUtfString();
	inline public function nextBytes(limit:Int = 0):Bytes return arpImpl.nextBytes(limit);

	inline public function writeBool(value:Bool):Void arpImpl.writeBool(value);
	inline public function writeInt8(value:Int):Void arpImpl.writeInt8(value);
	inline public function writeInt16(value:Int):Void arpImpl.writeInt16(value);
	inline public function writeInt32(value:Int):Void arpImpl.writeInt32(value);
	inline public function writeUInt8(value:UInt):Void arpImpl.writeUInt8(value);
	inline public function writeUInt16(value:UInt):Void arpImpl.writeUInt16(value);
	inline public function writeUInt32(value:UInt):Void arpImpl.writeUInt32(value);
	inline public function writeFloat(value:Float):Void arpImpl.writeFloat(value);
	inline public function writeDouble(value:Float):Void arpImpl.writeDouble(value);
	inline public function writeBytes(bytes:Bytes, offset:UInt = 0, length:UInt = 0):Void arpImpl.writeBytes(bytes, offset, length);
	inline public function writeUtfBytes(value:String):Void arpImpl.writeUtfBytes(value);
	inline public function writeBlob(bytes:Bytes):Void arpImpl.writeBlob(bytes);
	inline public function writeUtfBlob(value:String):Void arpImpl.writeUtfBlob(value);
	inline public function writeUtfString(value:Null<String>):Void arpImpl.writeUtfString(value);
}


