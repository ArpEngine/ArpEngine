package arpx.field;

import arp.domain.IArpObject;
import arp.ds.decorators.OmapDecorator;
import arp.ds.IOmap;
import arp.ds.lambda.OmapOp;
import arp.hit.fields.HitField;
import arp.hit.fields.HitObjectField;
import arp.hit.strategies.HitWithCuboid;
import arp.hit.structs.HitGeneric;
import arp.task.ITickable;
import arpx.anchor.Anchor;
import arpx.impl.cross.field.FieldImpl;
import arpx.impl.cross.field.IFieldImpl;
import arpx.mortal.Mortal;
import arpx.reactFrame.ReactFrame;

@:arpType("field")
class Field implements IArpObject implements ITickable implements IFieldImpl {

	@:arpBarrier @:arpField(true) public var initMortals:IOmap<String, Mortal>;
	@:arpBarrier @:arpField(false) private var _mortals:IOmap<String, Mortal>;
	@:arpBarrier @:arpField public var anchors:IOmap<String, Anchor>;

	public var mortals(default, null):IOmap<String, Mortal>;
	public var gridSize(get, never):Int;
	public var width(get, never):Int;
	public var height(get, never):Int;

	private var hitField:HitObjectField<HitGeneric, HitMortal>;
	private var anchorField:HitField<HitGeneric, Anchor>;

	@:arpImpl private var arpImpl:FieldImpl;

	public function new() return;

	@:arpHeatUp private function heatUp():Bool {
		if (this.mortals == null) this.mortals = @:privateAccess new MortalMap(this);
		if (this.hitField == null) this.hitField = new HitObjectField<HitGeneric, HitMortal>(new HitWithCuboid());
		if (this.anchorField == null) this.anchorField = new HitField<HitGeneric, Anchor>(new HitWithCuboid());
		this.reinitMortals();
		return true;
	}

	private function get_gridSize():Int {
		return 1;
	}

	private function get_width():Int {
		return 0;
	}

	private function get_height():Int {
		return 0;
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

	public function reinitMortals():Void {
		OmapOp.copy(this.initMortals, this.mortals);
	}

	public function tick(timeslice:Float):Bool {
		for (mortal in this.mortals) mortal.tick(timeslice);
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
		return true;
	}

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

	public function mortalAt(self:Mortal, x:Float, y:Float, z:Float, hitType:String):Mortal {
		var result:Mortal = null;
		this.hitRaw(new HitGeneric().setCuboid(x, y, z, 0, 0, 0), hitType, function(other:HitMortal):Bool {
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
		this.hitRaw(new HitGeneric().setCuboid(x, y, z, 0, 0, 0), hitType, function(other:HitMortal):Bool {
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
		this.anchorField.hitRaw(new HitGeneric().setCuboid(x, y, z, 0, 0, 0), function(other:Anchor):Bool {
			result = other;
			return true;
		});
		return result;
	}

	public function anchorsAt(x:Float, y:Float, z:Float):Array<Anchor> {
		var result:Array<Anchor> = [];
		this.anchorField.hitRaw(new HitGeneric().setCuboid(x, y, z, 0, 0, 0), function(other:Anchor):Bool {
			result.push(other);
			return false;
		});
		return result;
	}
}

class MortalMap extends OmapDecorator<String, Mortal> {

	private var field:Field;

	private function new(field:Field) {
		super(@:privateAccess field._mortals);
		this.field = field;
	}

	//write
	override public function addPair(k:String, v:Mortal):Void {
		if (@:privateAccess v.field != null) @:privateAccess v.field._mortals.remove(v);
		@:privateAccess v.field = this.field;
		this.omap.addPair(k, v);
	}
	override public function insertPairAt(index:Int, k:String, v:Mortal):Void {
		if (@:privateAccess v.field != null) @:privateAccess v.field._mortals.remove(v);
		@:privateAccess v.field = this.field;
		this.omap.insertPairAt(index, k, v);
	}

	// remove
	override public function remove(v:Mortal):Bool {
		@:privateAccess v.field = null;
		return this.omap.remove(v);
	}
	override public function removeKey(k:String):Bool {
		if (!this.omap.hasKey(k)) return false;
		@:privateAccess this.omap.get(k).field = null;
		return this.omap.removeKey(k);
	}
	override public function removeAt(index:Int):Bool {
		if (index < 0 || index >= this.omap.length) return false;
		@:privateAccess this.omap.getAt(index).field = null;
		return this.omap.removeAt(index);
	}
	override public function pop():Null<Mortal> {
		if (this.omap.isEmpty()) return null;
		@:privateAccess this.omap.last().field = null;
		return this.omap.pop();
	}
	override public function shift():Null<Mortal> {
		if (this.omap.isEmpty()) return null;
		@:privateAccess this.omap.first().field = null;
		return this.omap.shift();
	}
	override public function clear():Void {
		@:privateAccess for (v in this.omap) v.field = null;
		this.omap.clear();
	}
}
