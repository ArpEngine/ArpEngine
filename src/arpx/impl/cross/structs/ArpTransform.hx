package arpx.impl.cross.structs;

import arp.domain.IArpStruct;
import arp.persistable.IPersistOutput;
import arp.persistable.IPersistInput;
import arp.seed.ArpSeed;

import arpx.impl.cross.geom.MatrixImpl;
import arpx.impl.cross.geom.PointImpl;

@:arpStruct("Transform")
@:arpStructPlaceholder("xx,yx,xy,yy;tx,ty", { a: "xx", b: "yx", c: "xy", d: "yy", x: "tx", y: "ty" })
class ArpTransform implements IArpStruct {

	public var impl(default, null):MatrixImpl;

	public function new() {
		this.impl = MatrixImpl.alloc();
		this.impl.identity();
	}

	inline public function reset(a:Float = 1, b:Float = 0, c:Float = 0, d:Float = 1, tx:Float = 0, ty:Float = 0):ArpTransform {
		this.impl.reset2d(a, b, c, d, tx, ty);
		return this;
	}

	public function initWithSeed(seed:ArpSeed):ArpTransform {
		if (seed == null) return this;
		if (seed.isSimple) return this.initWithString(seed.value, seed.env.getUnit);

		var xx:Float = 1.0;
		var yx:Float = 0.0;
		var xy:Float = 0.0;
		var yy:Float = 1.0;
		var tx:Float = 0.0;
		var ty:Float = 0.0;
		for (child in seed) {
			switch (child.seedName) {
				case "a", "xx": xx = arp.utils.ArpSeedUtil.parseFloatDefault(child, 1.0);
				case "b", "yx": yx = arp.utils.ArpSeedUtil.parseFloatDefault(child, 0.0);
				case "c", "xy": xy = arp.utils.ArpSeedUtil.parseFloatDefault(child, 0.0);
				case "d", "yy": yy = arp.utils.ArpSeedUtil.parseFloatDefault(child, 1.0);
				case "x", "tx": tx = arp.utils.ArpSeedUtil.parseFloatDefault(child);
				case "y", "ty": ty = arp.utils.ArpSeedUtil.parseFloatDefault(child);
			}
		}
		return this.reset(xx, yx, xy, yy, tx, ty);
	}

	public function initWithString(definition:String, getUnit:String->Float):ArpTransform {
		if (definition == null) return this;
		var array:Array<String> = ~/[;,]/g.split(definition);
		if (array.length < 6) return this;
		var xx = arp.utils.ArpStringUtil.parseRichFloat(array[0], getUnit, 1.0);
		var yx = arp.utils.ArpStringUtil.parseRichFloat(array[1], getUnit, 0.0);
		var xy = arp.utils.ArpStringUtil.parseRichFloat(array[2], getUnit, 0.0);
		var yy = arp.utils.ArpStringUtil.parseRichFloat(array[3], getUnit, 1.0);
		var tx = arp.utils.ArpStringUtil.parseRichFloat(array[4], getUnit);
		var ty = arp.utils.ArpStringUtil.parseRichFloat(array[5], getUnit);
		return this.reset(xx, yx, xy, yy, tx, ty);
	}

	public function readSelf(input:IPersistInput):Void {
		this.reset(
			input.readDouble("xx"),
			input.readDouble("yx"),
			input.readDouble("xy"),
			input.readDouble("yy"),
			input.readDouble("tx"),
			input.readDouble("ty")
		);
	}

	public function writeSelf(output:IPersistOutput):Void {
		var array:Array<Float> = this.toData();
		output.writeDouble("xx", this.impl.xx);
		output.writeDouble("yx", this.impl.yx);
		output.writeDouble("xy", this.impl.xy);
		output.writeDouble("yy", this.impl.yy);
		output.writeDouble("tx", this.impl.tx);
		output.writeDouble("ty", this.impl.ty);
	}

	inline public function readData(data:Array<Float>):ArpTransform {
		if (data.length < 6) return this;
		this.impl.reset2d(data[0], data[1], data[2], data[3], data[4], data[5]);
		return this;
	}

	inline public function toData(data:Array<Float> = null):Array<Float> {
		if (data == null) data = [];
		data[0] = this.impl.xx;
		data[1] = this.impl.yx;
		data[2] = this.impl.xy;
		data[3] = this.impl.yy;
		data[4] = this.impl.tx;
		data[5] = this.impl.ty;
		return data;
	}

	public function clone():ArpTransform {
		return new ArpTransform().copyFrom(this);
	}

	public function copyFrom(source:ArpTransform):ArpTransform {
		this.impl.copyFrom(source.impl.raw);
		return this;
	}

	public function readPoint(pt:PointImpl):ArpTransform {
		this.impl.reset2d(1, 0, 0, 1, pt.x, pt.y);
		return this;
	}

	public function readMatrix(matrix:MatrixImpl):ArpTransform {
		this.impl.copyFrom(matrix.raw);
		return this;
	}

	inline private function setOrAllocPointImpl(x:Float, y:Float, pt:PointImpl = null) {
		if (pt == null) return PointImpl.alloc(x, y);
		pt.reset(x, y);
		return pt;
	}

	public function asPoint(pt:PointImpl = null):PointImpl {
		if (this.impl.xx == 1 && this.impl.yx == 0 && this.impl.xy == 0 && this.impl.yy == 1) {
			return setOrAllocPointImpl(this.impl.tx, this.impl.ty, pt);
		}
		return null;
	}

	public function toPoint(pt:PointImpl = null):PointImpl {
		return setOrAllocPointImpl(this.impl.tx, this.impl.ty, pt);
	}

	public function setXY(x:Float, y:Float):ArpTransform {
		this.impl.tx = x;
		this.impl.ty = y;
		return this;
	}

	public function invert():ArpTransform {
		this.impl.invert();
		return this;
	}

	public function resetSkew():ArpTransform {
		this.impl.resetSkew();
		return this;
	}

	public function resetScale(scale:Float = 1):ArpTransform {
		this.impl.resetScale(scale);
		return this;
	}

	public function resetTranslation():ArpTransform {
		this.impl.resetTranslation();
		return this;
	}

	public function transformPoint(pt:PointImpl):PointImpl {
		pt.transform(this.impl);
		return pt;
	}

	public function prependTransform(transform:ArpTransform):ArpTransform {
		this.impl.prependMatrix(transform.impl);
		return this;
	}

	public function prependXY(x:Float, y:Float):ArpTransform {
		this.impl.prependXY(x, y);
		return this;
	}

	public function appendTransform(transform:ArpTransform):ArpTransform {
		this.impl.appendMatrix(transform.impl);
		return this;
	}

	public function appendXY(x:Float, y:Float):ArpTransform {
		this.impl.appendXY(x, y);
		return this;
	}
}
