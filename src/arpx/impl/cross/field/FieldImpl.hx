package arpx.impl.cross.field;

import haxe.ds.ArraySort;
import arpx.impl.cross.display.RenderContext;
import arpx.field.Field;
import arpx.impl.ArpObjectImplBase;
import arpx.mortal.Mortal;

class FieldImpl extends ArpObjectImplBase implements IFieldImpl {

	private var field:Field;

	public function new(field:Field) {
		super();
		this.field = field;
	}

	public function render(context:RenderContext):Void {
		copySortedMortals(field.mortals, context);
	}

	private static function compareMortals(a:Mortal, b:Mortal):Int {
		return Reflect.compare(a.position.y + a.position.z, b.position.y + b.position.z);
	}

	public static function copySortedMortals(mortals:Iterable<Mortal>, context:RenderContext):Void {
		if (mortals == null) return;
		var temp:Array<Mortal> = [for (m in mortals) m];
		ArraySort.sort(temp, compareMortals);
		for (m in temp) {
			m.render(context);
		}
	}
}
