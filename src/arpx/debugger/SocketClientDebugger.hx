package arpx.debugger;

import haxe.Json;
import arp.domain.ArpUntypedSlot;
import arp.domain.core.ArpSid;
import arp.domain.core.ArpType;
import arp.domain.dump.ArpDomainDump;
import arp.domain.dump.ArpDumpAnon;
import arp.domain.IArpObject;
import arp.events.ArpProgressEvent;
import arp.io.BlobInput;
import arp.persistable.AnonPersistOutput;
import arp.persistable.IPersistable;
import arpx.debugger.DebuggerCommand;
import arpx.socketClient.SocketClient;

@:arpType("debugger", "socketClient")
class SocketClientDebugger implements IArpObject {

	@:arpField @:arpBarrier public var socketClient:SocketClient;
	private var blobInput:BlobInput;

	public function new() {
	}

	@:arpHeatUp
	private function heatUp():Bool {
		if (this.socketClient != null) {
			this.blobInput = new BlobInput(this.socketClient);
			this.blobInput.bigEndian = true;
			this.socketClient.onData.push(this.onSocketData);
			this.socketClient.onClose.push(this.onClose);
		}
		return true;
	}

	private function onSocketData(event:ArpProgressEvent):Void {
		var json:String = null;
		while ((json = this.blobInput.nextUtfBlob()) != null) {
			trace("SocketClientDebugger.onSocketData(): " + json);
			var result:Dynamic = null;
			var command:DebuggerCommand = Json.parse(json);
			switch (command.command) {
				case "types":
					var typesResult:DebuggerTypesResult = {
						command: "types",
						arpTypes: this.arpDomain.allArpTypes.map(function(arpType:ArpType):String return arpType.toString())
					};
					result = typesResult;
				case "dir":
					var arpType:ArpType = new ArpType(command.arpType);
					var typeFilter:ArpType->Bool = null;
					if (arpType != "*") typeFilter = function(value:ArpType):Bool return value == arpType;
					var dump:ArpDumpAnon = ArpDomainDump.anonPrinter.format(new ArpDomainDump(this.arpDomain, typeFilter).dumpSlotStatusByName());
					var dirResult:DebuggerDirResult = {
						command: "dir",
						arpType: arpType.toString(),
						arpDump: dump
					};
					result = dirResult;
				case "slot":
					var arpSid:ArpSid = new ArpSid(command.arpSid);
					var object:Dynamic = null;
					var arpTemplateName:String = null;
					var slot:ArpUntypedSlot = this.arpDomain.getSlot(arpSid);
					var value:IPersistable = try cast(slot.value, IPersistable) catch (e:Dynamic) null;
					if (value != null) {
						var output:AnonPersistOutput = new AnonPersistOutput(null, -1);
						value.writeSelf(output);
						object = output.data;
						arpTemplateName = "slot.arpTemplateName";
					}
					else {
						object = { };
					}
					var slotResult:DebuggerSlotResult = {
						command: "slot",
						arpSid: arpSid.toString(),
						object: object
					};
					result = slotResult;
				default:
					break;
			}
			this.socketClient.writeUtfBlob(Json.stringify(result));
		}
	}

	private function onClose(_:Any):Void {
		this.blobInput.flush();
	}
}
