package arpx.field;

import arp.domain.IArpObject;
import arp.ds.IOmap;
import arp.hit.fields.HitField;
import arp.hit.fields.HitObjectField;
import arp.hit.strategies.HitWithCuboid;
import arp.hit.structs.HitGeneric;
import arp.task.Heartbeat;
import arp.task.ITickable;
import arpx.anchor.Anchor;
import arpx.impl.cross.field.FieldImpl;
import arpx.impl.cross.field.IFieldImpl;
import arpx.input.focus.IInteractable;
import arpx.input.Input;
import arpx.mortal.Mortal;
import arpx.reactFrame.ReactFrame;
import arpx.structs.ArpHitCuboid;

@:arpType("field")
class Field implements IArpObject implements ITickable implements IInteractable implements IFieldImpl {

	@:arpBarrier @:arpDeepCopy @:arpField(true) public var mortals:IOmap<String, Mortal>;
	@:arpBarrier @:arpField(true) public var anchors:IOmap<String, Anchor>;

	private var hitField:HitObjectField<HitGeneric, HitMortal>;
	private var anchorField:HitField<HitGeneric, Anchor>;

	@:arpField public var bounds:ArpHitCuboid;

	@:arpImpl private var arpImpl:FieldImpl;

	public function new() {
		this.hitField = new HitObjectField<HitGeneric, HitMortal>(new HitWithCuboid());
		this.anchorField = new HitField<HitGeneric, Anchor>(new HitWithCuboid());
	}

	public function addHit(mortal:Mortal, hitType:String):HitGeneric {
		return hitField.add(mortal.asHitType(hitType));
	}

	public function findHit(mortal:Mortal, hitType:String):HitGeneric {
		return hitField.find(mortal.asHitType(hitType));
	}

	public function addAnchorHit(anchor:Anchor):HitGeneric {
		return anchorField.add(anchor);
	}

	public function tick(timeslice:Float):Heartbeat {
		for (cursor in this.mortals.amend()) {
			if (!cursor.value.tickChild(timeslice, this).isKeep()) cursor.remove();
		}
		for (anchor in this.anchors) anchor.refresh(this);
		this.hitField.tick();
		this.anchorField.tick();
		this.hitField.hitTest(function(a:HitMortal, b:HitMortal):Bool {
			if (a.hitType != b.hitType) return false;
			if (a.isComplex) {
				if (b.isComplex) {
					return false;
				} else {
					if (!a.mortal.complexHitTest(a.hit, b.hit)) return false;
				}
			} else if (b.isComplex) {
				if (!b.mortal.complexHitTest(b.hit, a.hit)) return false;
			}
			a.mortal.collide(this, b.mortal);
			b.mortal.collide(this, a.mortal);
			return false;
		});
		return Heartbeat.Keep;
	}

	public function interact(input:Input):Bool return false;

	public function bulkHitRaw(srcHitType:String, hitType:String, callback:(a:HitMortal, b:HitMortal)->Bool):Void {
		// TODO seriously use layer
		this.hitField.hitTest(function(a:HitMortal, b:HitMortal):Bool {
			if (a.hitType != srcHitType) return false;
			if (b.hitType != hitType) return false;
			if (a.isComplex) {
				if (b.isComplex) {
					return false;
				} else {
					if (!a.mortal.complexHitTest(a.hit, b.hit)) return false;
				}
			} else if (b.isComplex) {
				if (!b.mortal.complexHitTest(b.hit, a.hit)) return false;
			}
			return callback(a, b);
		});
	}

	public function hitRaw(hit:HitGeneric, hitType:String, callback:HitMortal->Bool):Void {
		this.hitField.hitRaw(hit, function(other:HitMortal):Bool {
			if (other.hitType != hitType) return false;
			if (other.isComplex) {
				if (!other.mortal.complexHitTest(other.hit, hit)) return false;
			}
			return callback(other);
		});
	}

	public function contactRaw(hit:HitGeneric, hitType:String, callback:HitMortal->Bool):Void {
		this.hitField.contactRaw(hit, function(other:HitMortal):Bool {
			if (other.hitType != hitType) return false;
			if (other.isComplex) {
				if (!other.mortal.complexHitTest(other.hit, hit)) return false;
			}
			return callback(other);
		});
	}

	public function mortalAt(self:Mortal, x:Float, y:Float, z:Float, hitType:String):Mortal {
		var result:Mortal = null;
		this.contactRaw(new HitGeneric().setCuboid(x, y, z, 0, 0, 0), hitType, function(other:HitMortal):Bool {
			if (self != other.mortal) {
				result = other.mortal;
				return true;
			}
			return false;
		});
		return result;
	}

	public function mortalsAt(self:Mortal, x:Float, y:Float, z:Float, hitType:String):Array<Mortal> {
		var result:Array<Mortal> = [];
		this.contactRaw(new HitGeneric().setCuboid(x, y, z, 0, 0, 0), hitType, function(other:HitMortal):Bool {
			if (self != other.mortal) {
				result.push(other.mortal);
			}
			return false;
		});
		return result;
	}

	public function dispatchReactFrame(self:Mortal, reactFrame:ReactFrame, delay:Float):Void {
		this.hitRaw(reactFrame.exportHitGeneric(self.position, new HitGeneric()), reactFrame.hitType, function(other:HitMortal):Bool {
			if (self != other.mortal) {
				other.mortal.react(this, self, reactFrame, delay);
			}
			return false;
		});
	}

	public function anchorAt(x:Float, y:Float, z:Float):Anchor {
		var result:Anchor = null;
		this.anchorField.contactRaw(new HitGeneric().setCuboid(x, y, z, 0, 0, 0), function(other:Anchor):Bool {
			result = other;
			return true;
		});
		return result;
	}

	public function anchorsAt(x:Float, y:Float, z:Float):Array<Anchor> {
		var result:Array<Anchor> = [];
		this.anchorField.contactRaw(new HitGeneric().setCuboid(x, y, z, 0, 0, 0), function(other:Anchor):Bool {
			result.push(other);
			return false;
		});
		return result;
	}
}
