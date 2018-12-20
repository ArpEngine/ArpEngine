package arpx.impl.cross.socketClient;

import haxe.io.Bytes;
import arpx.impl.ArpObjectImplBase;

class SocketClientNullImpl extends ArpObjectImplBase implements ISocketClientImpl {

	public function new() {
		super();
	}

	public var bigEndian(get, set):Bool;
	inline public function get_bigEndian():Bool return false;
	inline public function set_bigEndian(value:Bool):Bool return false;

	inline public function readBool():Bool throw "EOF";
	inline public function readInt8():Int throw "EOF";
	inline public function readInt16():Int throw "EOF";
	inline public function readInt32():Int throw "EOF";
	inline public function readUInt8():UInt throw "EOF";
	inline public function readUInt16():UInt throw "EOF";
	inline public function readUInt32():UInt throw "EOF";
	inline public function readFloat():Float throw "EOF";
	inline public function readDouble():Float throw "EOF";
	inline public function readBytes(bytes:Bytes, offset:UInt = 0, length:UInt = 0):Void throw "EOF";
	inline public function readUtfBytes(length:UInt):String throw "EOF";
	inline public function readBlob():Bytes throw "EOF";
	inline public function readUtfBlob():String throw "EOF";
	inline public function readUtfString():Null<String> throw "EOF";
	inline public function nextBytes(limit:Int = 0):Bytes throw "EOF";

	inline public function writeBool(value:Bool):Void throw "closed";
	inline public function writeInt8(value:Int):Void throw "closed";
	inline public function writeInt16(value:Int):Void throw "closed";
	inline public function writeInt32(value:Int):Void throw "closed";
	inline public function writeUInt8(value:UInt):Void throw "closed";
	inline public function writeUInt16(value:UInt):Void throw "closed";
	inline public function writeUInt32(value:UInt):Void throw "closed";
	inline public function writeFloat(value:Float):Void throw "closed";
	inline public function writeDouble(value:Float):Void throw "closed";
	inline public function writeBytes(bytes:Bytes, offset:UInt = 0, length:UInt = 0):Void throw "closed";
	inline public function writeUtfBytes(value:String):Void throw "closed";
	inline public function writeBlob(bytes:Bytes):Void throw "closed";
	inline public function writeUtfBlob(value:String):Void throw "closed";
	inline public function writeUtfString(value:Null<String>):Void throw "closed";

}


