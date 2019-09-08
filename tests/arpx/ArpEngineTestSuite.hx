package arpx;

import arp.testParams.PersistIoProviders.*;
import arpx.automaton.AutomatonCase;
import arpx.driver.LinearDriverCase;
import arpx.file.LocalFileCase;
import arpx.impl.cross.structs.ArpTransformCase;
import arpx.input.KeyInputCase;
import arpx.macro.ArpStructsMacroArpObjectCase;
import arpx.menu.MenuCase;
import arpx.paramsOp.RewireParamsOpCase;
import arpx.structs.ArpColorCase;
import arpx.structs.ArpColorFlashCase;
import arpx.structs.ArpDirectionCase;
import arpx.structs.ArpParamsCase;
import arpx.structs.ArpPositionCase;
import arpx.structs.ArpRangeCase;
import arpx.text.ParametrizedTextDataCase;
import arpx.text.TextDataCase;
import picotest.PicoTestRunner;

#if arp_display_backend_flash
import arpx.impl.cross.structs.ArpTransformFlashCase;
#elseif arp_display_backend_heaps
import arpx.impl.cross.structs.ArpTransformHeapsCase;
#end

class ArpEngineTestSuite {
	public static function addTo(r:PicoTestRunner) {
		r.load(ArpColorCase, persistIoProvider());
		r.load(ArpDirectionCase, persistIoProvider());
		r.load(ArpParamsCase, persistIoProvider());
		r.load(ArpPositionCase, persistIoProvider());
		r.load(ArpRangeCase, persistIoProvider());

		#if (flash || openfl)
		r.load(ArpColorFlashCase);
		#end

		r.load(ArpStructsMacroArpObjectCase);

		#if !arp_display_backend_stub
		r.load(ArpTransformCase, persistIoProvider());
		#end

		#if arp_display_backend_flash
		r.load(ArpTransformFlashCase);
		#elseif arp_display_backend_heaps
		r.load(ArpTransformHeapsCase);
		#end

		r.load(ArpEngineComponentsCase);

		r.load(AutomatonCase);

		r.load(LinearDriverCase);

		r.load(LocalFileCase);

		r.load(KeyInputCase);

		r.load(MenuCase);

		r.load(RewireParamsOpCase);

		r.load(TextDataCase);
		r.load(ParametrizedTextDataCase);
	}
}
