package arpx.macro.mocks;

import arp.domain.IArpObject;
import arpx.structs.ArpColor;
import arpx.structs.ArpDirection;
import arpx.structs.ArpHitCuboid;
import arpx.structs.ArpParams;
import arpx.structs.ArpPosition;
import arpx.structs.ArpRange;

@:arpType("mock", "structMacro")
class MockStructMacroArpObject implements IArpObject {

	@:arpField public var arpColorField:ArpColor;
	@:arpField public var arpDirectionField:ArpDirection;
	@:arpField public var arpHitCuboidField:ArpHitCuboid;
	@:arpField public var arpParamsField:ArpParams;
	@:arpField public var arpPositionField:ArpPosition;
	@:arpField public var arpRangeField:ArpRange;

	public function new() {
	}
}
