package arpx.impl.cross.file;

import haxe.io.Bytes;
import arp.impl.IArpObjectImpl;
import arp.io.IInput;

interface IFileImpl extends IArpObjectImpl {
	var exists(get, never):Bool;
	function bytes():Bytes;
	function read():IInput;
}
