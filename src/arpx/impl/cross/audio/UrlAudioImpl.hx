package arpx.impl.cross.audio;

#if arp_audio_backend_flash
typedef UrlAudioImpl = arpx.impl.flash.audio.UrlAudioImpl;
#elseif arp_audio_backend_heaps
typedef UrlAudioImpl = arpx.impl.heaps.audio.UrlAudioImpl;
#elseif arp_audio_backend_js
typedef UrlAudioImpl = arpx.impl.js.audio.UrlAudioImpl;
#elseif arp_audio_backend_sys
typedef UrlAudioImpl = arpx.impl.sys.audio.UrlAudioImpl;
#elseif (arp_audio_backend_stub || arp_backend_display)
typedef UrlAudioImpl = arpx.impl.stub.audio.UrlAudioImpl;
#end
