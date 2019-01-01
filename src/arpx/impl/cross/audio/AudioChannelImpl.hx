package arpx.impl.cross.audio;

#if arp_audio_backend_flash
typedef AudioChannelImpl = arpx.impl.flash.audio.AudioChannelImpl;
#elseif arp_audio_backend_heaps
typedef AudioChannelImpl = arpx.impl.heaps.audio.AudioChannelImpl;
#elseif arp_audio_backend_js
typedef AudioChannelImpl = arpx.impl.js.audio.AudioChannelImpl;
#elseif arp_audio_backend_sys
typedef AudioChannelImpl = arpx.impl.sys.audio.AudioChannelImpl;
#elseif (arp_audio_backend_stub || arp_backend_display)
typedef AudioChannelImpl = arpx.impl.stub.audio.AudioChannelImpl;
#end
