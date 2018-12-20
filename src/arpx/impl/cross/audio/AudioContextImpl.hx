package arpx.impl.cross.audio;

#if arp_audio_backend_flash
typedef AudioContextImpl = arpx.impl.flash.audio.AudioContextImpl;
#elseif arp_audio_backend_heaps
typedef AudioContextImpl = arpx.impl.heaps.audio.AudioContextImpl;
#elseif arp_audio_backend_js
typedef AudioContextImpl = arpx.impl.js.audio.AudioContextImpl;
#elseif arp_audio_backend_sys
typedef AudioContextImpl = arpx.impl.sys.audio.AudioContextImpl;
#elseif (arp_audio_backend_stub || arp_backend_display)
typedef AudioContextImpl = arpx.impl.stub.audio.AudioContextImpl;
#end
