package arpx.impl.cross.audio;

#if arp_audio_backend_flash
typedef ResourceAudioImpl = arpx.impl.flash.audio.ResourceAudioImpl;
#elseif arp_audio_backend_heaps
typedef ResourceAudioImpl = arpx.impl.heaps.audio.ResourceAudioImpl;
#elseif arp_audio_backend_js
typedef ResourceAudioImpl = arpx.impl.js.audio.ResourceAudioImpl;
#elseif arp_audio_backend_sys
typedef ResourceAudioImpl = arpx.impl.sys.audio.ResourceAudioImpl;
#elseif (arp_audio_backend_stub || arp_backend_display)
typedef ResourceAudioImpl = arpx.impl.stub.audio.ResourceAudioImpl;
#end
