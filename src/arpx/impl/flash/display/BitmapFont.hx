package arpx.impl.flash.display;

#if (flash || openfl)

import flash.display.BitmapData;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextLineMetrics;

class BitmapFont {

	private var bitmapDataByCharCode:Map<Int, BitmapData>;
	private var boundsByCharCode:Map<Int, Rectangle>;
	private var fixWidth:Bool = true;
	private var minHeight:Int;
	private var charWidth:Int;
	private var charHeight:Int;

	private var descent:Int;
	public var leading(default, null):Int;

	public var lineHeight(get, never):Int;
	private function get_lineHeight():Int return charHeight + leading;

	private var _workTextField:TextField;
	private var _workPt:Point= new Point();
	private var _workMatrix:Matrix = new Matrix();
	private var _workColorTransform:ColorTransform = new ColorTransform();
	private var _workRect:Rectangle = new Rectangle();

	public function new(textFormat:TextFormat, minheight:Int, charwidth:Int, fixwidth:Bool) {
		this.minHeight = minheight;
		this.charWidth = charwidth;
		this.fixWidth = fixwidth;
		this.dispose();

		this._workTextField = new TextField();
		this._workTextField.autoSize = TextFieldAutoSize.LEFT;
		this._workTextField.textColor = 0xffffffff;
		textFormat.color = 0xffffffff;
		this._workTextField.setTextFormat(textFormat);
		this._workTextField.defaultTextFormat = textFormat;
		this._workTextField.text = "M";
		var metrics:TextLineMetrics = this._workTextField.getLineMetrics(0);

		this.charHeight = (metrics.height > this.minHeight) ? Math.ceil(metrics.height) : this.minHeight;
		this.descent = Math.ceil(metrics.descent) - 1;
		this.leading = Math.ceil(metrics.leading);
		this._workRect.height = this.charHeight;
	}

	public function dispose():Void {
		if (this.bitmapDataByCharCode != null) for (bitmapData in this.bitmapDataByCharCode) bitmapData.dispose();
		this.bitmapDataByCharCode = new Map();
		this.boundsByCharCode = new Map();
	}

	private function prepareChr(charcode:Int):Void {
		this._workTextField.text = String.fromCharCode(charcode & 0xffff);
		var width:Int = this.fixWidth ? this.charWidth : Math.ceil(this._workTextField.width - 4);
		if (width == 0) return;
		var bitmapData:BitmapData = new BitmapData(width, this.charHeight, true, 0x00000000);
		this.bitmapDataByCharCode[charcode] = bitmapData;
		var matrix:Matrix = this._workMatrix;
		matrix.tx = -2; //2 is Flash Player border
		matrix.ty = -2; //2 is Flash Player border
		bitmapData.draw(this._workTextField, matrix);
		this.boundsByCharCode[charcode] = new Rectangle(0, 0, width, this.charHeight);
	}

	public function drawChar(target:BitmapData, charCode:Int, x:Int, y:Int, colorTransform:ColorTransform = null):Int {
		if (!this.boundsByCharCode.exists(charCode)) prepareChr(charCode);
		var bounds:Rectangle = this.boundsByCharCode.get(charCode);
		var bitmapData:BitmapData = this.bitmapDataByCharCode[charCode];
		if (bitmapData != null) {
			if (colorTransform == null) {
				//draw using copyPixels()
				var destPt:Point = this._workPt;
				destPt.x = x;
				destPt.y = y;
				target.copyPixels(bitmapData, bounds, destPt);
			} else {
				//draw using draw()
				var matrix:Matrix = this._workMatrix;
				matrix.tx = x;
				matrix.ty = y;
				target.draw(bitmapData, matrix, colorTransform);
			}
		}
		return Std.int(bounds.width);
	}

	public function getBounds(charCode:Int):Rectangle {
		if (!this.boundsByCharCode.exists(charCode)) this.prepareChr(charCode);
		return this.boundsByCharCode.get(charCode);
	}

	public static function getColorTransform(textColor:UInt, fillColor:UInt):ColorTransform {
		var ta:Int = (textColor >> 24) & 255;
		var tr:Int = (textColor >> 16) & 255;
		var tg:Int = (textColor >> 8) & 255;
		var tb:Int = (textColor) & 255;
		var fa:Int = (fillColor >> 24) & 255;
		var fr:Int = (fillColor >> 16) & 255;
		var fg:Int = (fillColor >> 8) & 255;
		var fb:Int = (fillColor) & 255;
		return new ColorTransform((tr - fr) / 255, (tg - fg) / 255, (tb - fb) / 255, (ta - fa) / 255, fr, fg, fb, fa);
	}

	public function toString():String {
		return "[BitmapFont]";
	}

}

#end
