package arpx.impl.flash.audio;

#if (arp_audio_backend_flash || arp_backend_display)

import arpx.audio.ResourceAudio;
import arpx.impl.cross.audio.AudioChannel;
import arpx.impl.cross.audio.AudioContext;
import arpx.impl.cross.audio.IAudioImpl;
import flash.media.Sound;
import flash.media.SoundTransform;
import flash.utils.ByteArray;
import haxe.io.Bytes;
import haxe.Resource;

class ResourceAudioImpl extends ArpObjectImplBase implements IAudioImpl {

	private var audio:ResourceAudio;
	private var value:Sound;

	public function new(audio:ResourceAudio) {
		super();
		this.audio = audio;
	}

	override public function arpHeatUp():Bool {
		if (this.value != null) return true;

		var bytes:Bytes = Resource.getBytes(audio.src);
		this.value = new Sound();
		var byteArray:ByteArray = bytes.getData();
		byteArray.position = 0;
		this.value.loadCompressedDataFromByteArray(byteArray, byteArray.length);
		return true;
	}

	override public function arpHeatDown():Bool {
		this.value = null;
		return true;
	}

	public function play(context:AudioContext, loop:Bool, volume:Float):AudioChannel {
		return this.value.play(0, loop ? 0x7fffffff : 0, new SoundTransform(volume));
	}
}

#end
