package arpx.impl.cross.audio;

#if arp_audio_backend_flash
typedef AudioChannel = arpx.impl.flash.audio.AudioChannel;
#elseif arp_audio_backend_heaps
typedef AudioChannel = arpx.impl.heaps.audio.AudioChannel;
#elseif arp_audio_backend_js
typedef AudioChannel = arpx.impl.js.audio.AudioChannel;
#elseif arp_audio_backend_sys
typedef AudioChannel = arpx.impl.sys.audio.AudioChannel;
#elseif (arp_audio_backend_stub || arp_backend_display)
typedef AudioChannel = arpx.impl.stub.audio.AudioChannel;
#end
