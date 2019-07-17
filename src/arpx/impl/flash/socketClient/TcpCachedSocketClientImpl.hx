package arpx.impl.flash.socketClient;

#if (arp_socket_backend_flash || arp_backend_display)

import flash.errors.SecurityError;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.net.Socket;
import haxe.io.Bytes;
import arp.events.ArpProgressEvent;
import arp.events.IArpSignalIn;
import arp.io.BufferedInput;
import arp.io.BufferedOutput;
import arp.io.flash.DataInputWrapper;
import arp.io.flash.DataOutputWrapper;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.socketClient.ISocketClientImpl;
import arpx.socketClient.TcpCachedSocketClient;

class TcpCachedSocketClientImpl extends ArpObjectImplBase implements ISocketClientImpl {

	private var socketClient:TcpCachedSocketClient;
	private var onData:IArpSignalIn<ArpProgressEvent>;
	private var onClose:IArpSignalIn<Any>;

	public var bigEndian(get, set):Bool;
	inline public function get_bigEndian():Bool return false;
	inline public function set_bigEndian(value:Bool):Bool return false;

	private var socket:Socket;
	private var output:BufferedOutput;
	private var input:BufferedInput;

	public function new(socketClient:TcpCachedSocketClient) {
		super();
		this.socketClient = socketClient;
		this.onData = @:privateAccess socketClient._onData;
		this.onClose = @:privateAccess socketClient._onClose;
	}

	override public function arpHeatUpNow():Bool {
		if (this.socketClient.host == null) {
			return true;
		}
		if (this.socket != null) {
			return true;
		}
		this.input = new BufferedInput();
		this.output = new BufferedOutput();
		this.input.bigEndian = true;
		this.output.bigEndian = true;
		this.socket = new Socket();
		this.socket.addEventListener(Event.CONNECT, this.onSocketConnect);
		this.socket.addEventListener(IOErrorEvent.IO_ERROR, this.onSocketError);
		this.socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSocketError);
		this.socket.addEventListener(ProgressEvent.SOCKET_DATA, this.onSocketData);
		this.socket.addEventListener(Event.CLOSE, this.onSocketClose);
		this.connect();
		// this.socketClient.arpDomain.waitFor(this.socketClient);
		return true;
	}

	private function connect():Void {
		var host:String = "127.0.0.1";
		var port:Int = 57772;
		var array:Array<String> = this.socketClient.host.split(":");
		if (array[0] != null) host = array[0];
		if (array[1] != null) try { port = Std.parseInt(array[1]); } catch(d:Dynamic) {}
		try {
			this.socket.connect(host, port);
		} catch (e:SecurityError) {
			this.socketClient.arpDomain.log("socketClient", e.message);
			onSocketError(null);
		}
	}

	private function reconnect():Void {
		this.socketClient.arpDomain.log("socketClient", "TcpCachedSocketClientImpl.reconnect()");
		this.connect();
	}

	private function onSocketConnect(event:Event):Void {
		// this.socketClient.arpDomain.notifyFor(this.socketClient);
		this.input.input = new DataInputWrapper(this.socket);
		this.output.output = new DataOutputWrapper(this.socket);
		this.input.bigEndian = true;
		this.output.bigEndian = true;
	}

	private function onSocketError(event:Event):Void {
		this.socketClient.arpDomain.notifyFor(this.socketClient);
		haxe.Timer.delay(this.reconnect, 1000);
	}

	private function onSocketData(event:ProgressEvent):Void {
		if (this.onData.willTrigger()) this.onData.dispatch(new ArpProgressEvent(event.bytesLoaded, event.bytesTotal));
	}

	private function onSocketClose(event:Event):Void {
		this.onClose.dispatch(null);
		this.reconnect();
	}

	private function flush():Void {
		this.output.flush();
	}

	override public function arpHeatDownNow():Bool {
		this.input = null;
		this.output = null;
		if (this.socket.connected) this.socket.close();
		this.socket = null;
		return true;
	}

	inline public function readBool():Bool return input.readBool();
	inline public function readInt8():Int return input.readInt8();
	inline public function readInt16():Int return input.readInt16();
	inline public function readInt32():Int return input.readInt32();
	inline public function readUInt8():UInt return input.readUInt8();
	inline public function readUInt16():UInt return input.readUInt16();
	inline public function readUInt32():UInt return input.readUInt32();
	inline public function readFloat():Float return input.readFloat();
	inline public function readDouble():Float return input.readDouble();
	inline public function readBytes(bytes:Bytes, offset:UInt = 0, length:UInt = 0):Void input.readBytes(bytes, offset, length);
	inline public function readUtfBytes(length:UInt):String return input.readUtfBytes(length);
	inline public function readBlob():Bytes return input.readBlob();
	inline public function readUtfBlob():String return input.readUtfBlob();
	inline public function readUtfString():Null<String> return input.readUtfString();
	inline public function nextBytes(limit:Int = 0):Bytes return input.nextBytes(limit);

	inline public function writeBool(value:Bool):Void { output.writeBool(value); output.flush(); }
	inline public function writeInt8(value:Int):Void { output.writeInt8(value); output.flush(); }
	inline public function writeInt16(value:Int):Void { output.writeInt16(value); output.flush(); }
	inline public function writeInt32(value:Int):Void { output.writeInt32(value); output.flush(); }
	inline public function writeUInt8(value:UInt):Void { output.writeUInt8(value); output.flush(); }
	inline public function writeUInt16(value:UInt):Void { output.writeUInt16(value); output.flush(); }
	inline public function writeUInt32(value:UInt):Void { output.writeUInt32(value); output.flush(); }
	inline public function writeFloat(value:Float):Void { output.writeFloat(value); output.flush(); }
	inline public function writeDouble(value:Float):Void { output.writeDouble(value); output.flush(); }
	inline public function writeBytes(bytes:Bytes, offset:UInt = 0, length:UInt = 0):Void { output.writeBytes(bytes, offset, length); output.flush(); }
	inline public function writeUtfBytes(value:String):Void { output.writeUtfBytes(value); output.flush(); }
	inline public function writeBlob(bytes:Bytes):Void { output.writeBlob(bytes); output.flush(); }
	inline public function writeUtfBlob(value:String):Void { output.writeUtfString(value); output.flush(); }
	inline public function writeUtfString(value:Null<String>):Void { output.writeUtfBlob(value); output.flush(); }

}

#end
