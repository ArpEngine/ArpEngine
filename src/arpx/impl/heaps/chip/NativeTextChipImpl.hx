package arpx.impl.heaps.chip;

#if (arp_display_backend_heaps || arp_backend_display)

import h2d.Font;
import h2d.Text;
import hxd.Charset;
import hxd.res.FontBuilder;

import arpx.impl.cross.chip.IChipImpl;
import arpx.impl.cross.display.RenderContext;
import arpx.impl.cross.geom.PointImpl;
import arpx.impl.heaps.display.CharsetCjk;
import arpx.impl.ArpObjectImplBase;
import arpx.chip.NativeTextChip;
import arpx.structs.IArpParamsRead;

class NativeTextChipImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:NativeTextChip;
	private var chars:String;
	private var font:Font;

	public function new(chip:NativeTextChip) {
		super();
		this.chip = chip;
	}

	override public function arpHeatUpNow():Bool {
		this.chars = Charset.DEFAULT_CHARS;
		return true;
	}

	override public function arpHeatDownNow():Bool {
		this.font.dispose();
		this.font = null;
		return true;
	}

	private var _workPt:PointImpl = PointImpl.alloc();
	public function render(context:RenderContext, params:IArpParamsRead = null):Void {
		var text:String = null;
		if (params != null) text = params.get("face");
		if (text == null) text = "null";

		for (i in 0...text.length) {
			var char:String = text.charAt(i);
			if (this.chars.indexOf(char) < 0) {
				this.chars += char;
				if (this.font != null) this.font.dispose();
				this.font = null;
			}
		}

		if (this.font == null) {
			var fontName:String = this.chip.font;
			if (fontName == null) fontName = "_sans";
			this.font = @:privateAccess new FontBuilder(fontName, this.chip.fontSize, {
				antiAliasing: false,
				chars: chars,
				kerning: true
			}).build();
			this.font.charset = CharsetCjk.instance;
		}

		var t:Text = new Text(this.font, context.buf);
		t.maxWidth = this.chip.chipWidth;
		t.letterSpacing = 0;
		t.text = text;
		t.textColor = this.chip.color.value32;
		var pt:PointImpl = context.transform.toPoint(_workPt);
		t.x = pt.x;
		t.y = pt.y - this.chip.fontSize + 2;
	}
}

#end
