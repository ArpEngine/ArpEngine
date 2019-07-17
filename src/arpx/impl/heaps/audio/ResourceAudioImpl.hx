package arpx.impl.heaps.audio;

#if (arp_audio_backend_heaps || arp_backend_display)

import arpx.audio.ResourceAudio;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.audio.AudioChannel;
import arpx.impl.cross.audio.AudioContext;
import arpx.impl.cross.audio.IAudioImpl;
import haxe.io.Bytes;
import haxe.Resource;
import hxd.fs.BytesFileSystem.BytesFileEntry;
import hxd.fs.FileEntry;
import hxd.res.Sound;

class ResourceAudioImpl extends ArpObjectImplBase implements IAudioImpl {

	private var audio:ResourceAudio;
	private var value:Sound;

	public function new(audio:ResourceAudio) {
		super();
		this.audio = audio;
	}

	override public function arpHeatUpNow():Bool {
		if (value != null) return true;
		var bytes:Bytes = Resource.getBytes(audio.src);
		var fileEntry:FileEntry = new BytesFileEntry('__arp__/audio/resource/${audio.src}', bytes);

		this.value = new Sound(fileEntry);
		return true;
	}

	override public function arpHeatDownNow():Bool {
		this.value.dispose();
		this.value = null;
		return true;
	}

	public function play(context:AudioContext, loop:Bool, volume:Float):AudioChannel {
		return this.value.play(loop, volume);
	}
}

#end
