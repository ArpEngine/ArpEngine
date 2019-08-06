package arpx.motionSet;

import arp.domain.IArpObject;
import arp.ds.IList;
import arp.ds.IMap;
import arpx.motion.Motion;
import arpx.nextMotion.NextMotion;

@:arpType("motionSet", "motionSet")
class MotionSet implements IArpObject {

	@:arpField(true) public var motions:IMap<String, Motion>;
	@:arpField(true) public var nextMotions:IList<NextMotion>;
	@:arpField public var initMotion:Motion;

	public function new() {
	}

	public function nextMotion(actionName:String, time:Float):Motion {
		for (nextMotion in this.nextMotions) {
			if (nextMotion.timeRange.hasValue && !nextMotion.timeRange.contains(time)) continue;
			if (actionName == nextMotion.action) {
				return nextMotion.motion;
			}
		}
		return this.motions.get(actionName);
	}
}


