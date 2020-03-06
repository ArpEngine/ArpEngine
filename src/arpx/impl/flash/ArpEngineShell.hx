package arpx.impl.flash;

#if (arp_display_backend_flash || arp_backend_display)

import arp.domain.ArpDomain;
import arpx.impl.cross.display.DisplayContext;
import arpx.impl.cross.ArpEngineShellBase;
import arpx.impl.cross.structs.ArpTransform;
import arpx.structs.ArpColor;
import flash.Lib;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.PixelSnapping;
import flash.events.Event;
import flash.geom.Matrix;

class ArpEngineShell extends ArpEngineShellBase {

	public function new(domain:ArpDomain, config:ArpEngineConfig) {
		super(domain, config);
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, this.onFirstFrame);
	}

	private function onEnterFrame(event:Event):Void {
		this.domainRawTick(60 / Lib.current.stage.frameRate);
		doRender(this.displayContext);
	}

	private function onFirstFrame(event:Event):Void {
		Lib.current.stage.removeEventListener(Event.ENTER_FRAME, this.onFirstFrame);
		this.onStart();
	}

	override private function createDisplayContext():DisplayContext {
		switch (bufferMode) {
			case ArpEngineShellBufferMode.Automatic, ArpEngineShellBufferMode.Logical:
				var bitmapData:BitmapData = new BitmapData(this.width, this.height, true, this.clearColor);
				var bitmap:Bitmap = new Bitmap(bitmapData, PixelSnapping.NEVER, false);
				bitmap.transform.matrix = new Matrix(scaleX, 0, 0, scaleY, 0, 0);
				Lib.current.addChild(bitmap);
				return new DisplayContext(bitmapData, new ArpTransform(), new ArpColor(this.clearColor));
			case ArpEngineShellBufferMode.Screen, ArpEngineShellBufferMode.Device /* Device scaling is todo */:
				var bitmapData:BitmapData = new BitmapData(Math.ceil(this.width * this.scaleX), Math.ceil(this.height * this.scaleY), true, this.clearColor);
				var bitmap:Bitmap = new Bitmap(bitmapData, PixelSnapping.NEVER, true);
				bitmap.transform.matrix = new Matrix();
				Lib.current.addChild(bitmap);
				return new DisplayContext(bitmapData, new ArpTransform().reset(scaleX, 0, 0, scaleY, 0, 0), new ArpColor(this.clearColor));
		}
	}
}

#end
