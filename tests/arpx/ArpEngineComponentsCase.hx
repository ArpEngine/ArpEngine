package arpx;

import arpx.anchor.Anchor;
import arpx.automaton.Automaton;
import arpx.camera.Camera;
import arpx.chip.Chip;
import arpx.chip.decorators.CompositeChip;
import arpx.chip.decorators.DecorateChip;
import arpx.chip.decorators.FilterChip;
import arpx.chip.decorators.SelectChip;
import arpx.chip.decorators.TransformChip;
import arpx.chip.NativeTextChip;
import arpx.chip.RectChip;
import arpx.chip.StringChip;
import arpx.chip.TextureChip;
import arpx.console.Console;
import arpx.debugger.Debugger;
import arpx.debugger.SocketClientDebugger;
import arpx.external.decorators.CompositeExternal;
import arpx.external.External;
import arpx.external.FileExternal;
import arpx.faceList.FaceList;
import arpx.field.Field;
import arpx.file.File;
import arpx.file.ResourceFile;
import arpx.input.Input;
import arpx.input.KeyInput;
import arpx.input.LocalInput;
import arpx.logger.Logger;
import arpx.logger.SocketClientLogger;
import arpx.logger.StoreLogger;
import arpx.logger.TraceLogger;
import arpx.mortal.ChipMortal;
import arpx.mortal.CompositeMortal;
import arpx.mortal.Mortal;
import arpx.screen.AutomatonScreen;
import arpx.screen.CompositeScreen;
import arpx.screen.FieldScreen;
import arpx.screen.HudScreen;
import arpx.screen.Screen;
import arpx.socketClient.SocketClient;
import arpx.socketClient.TcpCachedSocketClient;
import arpx.socketClient.TcpSocketClient;
import arpx.state.AutomatonState;
import arpx.text.FixedTextData;
import arpx.text.ParametrizedTextData;
import arpx.text.TextData;
import arpx.texture.decorators.GridTexture;
import arpx.texture.FileTexture;
import arpx.texture.ResourceTexture;
import arpx.texture.Texture;
import picotest.PicoAssert.*;

class ArpEngineComponentsCase {

	public function testFields() {
		assertNotNull(new Anchor());

		assertNotNull(new Automaton());

		assertNotNull(new Camera());

		assertNotNull(new Chip());
		assertNotNull(new TextureChip());
		assertNotNull(new NativeTextChip());
		assertNotNull(new RectChip());
		assertNotNull(new StringChip());

		assertNotNull(new CompositeChip());
		assertNotNull(new DecorateChip());
		assertNotNull(new FilterChip());
		assertNotNull(new SelectChip());
		assertNotNull(new TransformChip());

		assertNotNull(new Console());

		assertNotNull(new Debugger());
		assertNotNull(new SocketClientDebugger());

		assertNotNull(new External());
		assertNotNull(new FileExternal());
		assertNotNull(new CompositeExternal());

		assertNotNull(new FaceList());

		assertNotNull(new Field());

		assertNotNull(new File());
		assertNotNull(new ResourceFile());

		assertNotNull(new Input());
		assertNotNull(new KeyInput());
		assertNotNull(new LocalInput());

		assertNotNull(new Logger());
		assertNotNull(new SocketClientLogger());
		assertNotNull(new StoreLogger());
		assertNotNull(new TraceLogger());

		assertNotNull(new Mortal());
		assertNotNull(new ChipMortal());
		assertNotNull(new CompositeMortal());

		assertNotNull(new SocketClient());
		assertNotNull(new TcpCachedSocketClient());
		assertNotNull(new TcpSocketClient());

		assertNotNull(new Screen());
		assertNotNull(new FieldScreen());
		assertNotNull(new AutomatonScreen());
		assertNotNull(new CompositeScreen());
		assertNotNull(new HudScreen());

		assertNotNull(new AutomatonState());

		assertNotNull(new TextData());
		assertNotNull(new FixedTextData());
		assertNotNull(new ParametrizedTextData());

		assertNotNull(new Texture());
		assertNotNull(new FileTexture());
		assertNotNull(new ResourceTexture());
		assertNotNull(new GridTexture());
	}

}
