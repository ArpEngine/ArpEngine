package arpx.driver;

import arp.task.Heartbeat;
import arp.domain.IArpObject;
import arpx.field.Field;
import arpx.mortal.Mortal;

@:arpType("driver", "null")
class Driver implements IArpObject {

	@:arpField public var dHitType:String;
	@:arpField public var time:Float;

	public function new() return;

	public function tick(field:Field, mortal:Mortal):Heartbeat return Heartbeat.Keep;

	public function towardD(mortal:Mortal, time:Float, x:Float = 0, y:Float = 0, z:Float = 0):Bool return false;

	public function startAction(mortal:Mortal, actionName:String, restart:Bool = false):Bool return false;
}


