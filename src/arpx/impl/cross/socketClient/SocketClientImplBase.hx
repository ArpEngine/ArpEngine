package arpx.impl.cross.socketClient;

import haxe.io.Bytes;
import arp.io.IInput;
import arp.io.IOutput;
import arpx.impl.ArpObjectImplBase;

class SocketClientImplBase extends ArpObjectImplBase implements ISocketClientImpl {

	public var bigEndian(get, set):Bool;
	inline public function get_bigEndian():Bool return false;
	inline public function set_bigEndian(value:Bool):Bool return false;

	private var input:IInput = null;
	private var output:IOutput = null;

	public function new() {
		super();
	}

	inline public function readBool():Bool if (input != null) return input.readBool() else throw "EOF";
	inline public function readInt8():Int if (input != null) return input.readInt8() else throw "EOF";
	inline public function readInt16():Int if (input != null) return input.readInt16() else throw "EOF";
	inline public function readInt32():Int if (input != null) return input.readInt32() else throw "EOF";
	inline public function readUInt8():UInt if (input != null) return input.readUInt8() else throw "EOF";
	inline public function readUInt16():UInt if (input != null) return input.readUInt16() else throw "EOF";
	inline public function readUInt32():UInt if (input != null) return input.readUInt32() else throw "EOF";
	inline public function readFloat():Float if (input != null) return input.readFloat() else throw "EOF";
	inline public function readDouble():Float if (input != null) return input.readDouble() else throw "EOF";
	inline public function readBytes(bytes:Bytes, offset:UInt = 0, length:UInt = 0):Void if (input != null) input.readBytes(bytes, offset, length) else throw "EOF";
	inline public function readUtfBytes(length:UInt):String if (input != null) return input.readUtfBytes(length) else throw "EOF";
	inline public function readBlob():Bytes if (input != null) return input.readBlob() else throw "EOF";
	inline public function readUtfBlob():String if (input != null) return input.readUtfBlob() else throw "EOF";
	inline public function readUtfString():Null<String> if (input != null) return input.readUtfString() else throw "EOF";
	inline public function nextBytes(limit:Int = 0):Bytes if (input != null) return input.nextBytes(limit) else throw "EOF";

	inline public function writeBool(value:Bool):Void if (output != null) output.writeBool(value) else throw "closed";
	inline public function writeInt8(value:Int):Void if (output != null) output.writeInt8(value) else throw "closed";
	inline public function writeInt16(value:Int):Void if (output != null) output.writeInt16(value) else throw "closed";
	inline public function writeInt32(value:Int):Void if (output != null) output.writeInt32(value) else throw "closed";
	inline public function writeUInt8(value:UInt):Void if (output != null) output.writeUInt8(value) else throw "closed";
	inline public function writeUInt16(value:UInt):Void if (output != null) output.writeUInt16(value) else throw "closed";
	inline public function writeUInt32(value:UInt):Void if (output != null) output.writeUInt32(value) else throw "closed";
	inline public function writeFloat(value:Float):Void if (output != null) output.writeFloat(value) else throw "closed";
	inline public function writeDouble(value:Float):Void if (output != null) output.writeDouble(value) else throw "closed";
	inline public function writeBytes(bytes:Bytes, offset:UInt = 0, length:UInt = 0):Void if (output != null) output.writeBytes(bytes, offset, length) else throw "closed";
	inline public function writeUtfBytes(value:String):Void if (output != null) output.writeUtfBytes(value) else throw "closed";
	inline public function writeBlob(bytes:Bytes):Void if (output != null) output.writeBlob(bytes) else throw "closed";
	inline public function writeUtfBlob(value:String):Void if (output != null) output.writeUtfBlob(value) else throw "closed";
	inline public function writeUtfString(value:Null<String>):Void if (output != null) output.writeUtfString(value) else throw "closed";

}


