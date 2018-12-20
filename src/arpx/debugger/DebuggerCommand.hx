package arpx.debugger;

import arp.domain.dump.ArpDumpAnon;

typedef DebuggerCommand = {
	var command:String;
	@:optional var arpType:String;
	@:optional var arpSid:String;
};

typedef DebuggerResult = {
	var command:String;
}

typedef DebuggerTypesResult = {>DebuggerResult,
	var arpTypes:Array<String>;
};

typedef DebuggerDirResult = {>DebuggerResult,
	var arpType:String;
	var arpDump:ArpDumpAnon;
};

typedef DebuggerSlotResult = {>DebuggerResult,
	var arpSid:String;
	var object:Dynamic;
};
