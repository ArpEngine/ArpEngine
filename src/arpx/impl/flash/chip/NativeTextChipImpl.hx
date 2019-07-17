package arpx.impl.flash.chip;

#if (arp_display_backend_flash || arp_backend_display)

import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import arpx.chip.NativeTextChip;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.chip.IChipImpl;
import arpx.impl.cross.display.RenderContext;
import arpx.structs.IArpParamsRead;

class NativeTextChipImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:NativeTextChip;

	public function new(chip:NativeTextChip) {
		super();
		this.chip = chip;
	}

	override public function arpHeatUpNow():Bool {
		if (this.visual == null) {
			this.visual = this.createVisual();
			this.ascent = this.visual.getLineMetrics(0).ascent;
		}
		return true;
	}

	override public function arpHeatDownNow():Bool {
		this.visual = null;
		return true;
	}

	private var visual:TextField;
	private var ascent:Float;

	public function createVisual():TextField {
		var result:TextField = new TextField();
		result.text = " ";
		result.width = this.chip.chipWidth;
		result.height = this.chip.chipHeight;
		result.autoSize = TextFieldAutoSize.NONE;
		var fontName:String = this.chip.font;
		if (fontName == null) fontName = "_sans";
		result.defaultTextFormat = new TextFormat(fontName, this.chip.fontSize, this.chip.color.value32);
		result.embedFonts = fontName.charAt(0) != "_";
		result.selectable = false;
		result.wordWrap = true;
		return result;
	}

	public function render(context:RenderContext, params:IArpParamsRead = null):Void {
		this.arpHeatUpNow();
		context.dupTransform().prependXY(-2, -2 - this.ascent);
		var text:String = null;
		if (params != null) text = params.get("face");
		if (text == null) text = "null";
		this.visual.text = text;
		context.bitmapData.draw(this.visual, context.transform.impl.raw);
		context.popTransform();
	}

	/*
	public function exportChipSprite(params:ArpParams = null):AChipSprite {
		var result:NativeTextChipSprite = new NativeTextChipSprite(this, this.ascent);
		if (params != null) {
			result.refresh(params);
		}
		return result;
	}
	*/
}

#end
