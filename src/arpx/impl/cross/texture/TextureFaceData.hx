package arpx.impl.cross.texture;

#if arp_display_backend_flash
typedef TextureFaceData = arpx.impl.flash.texture.TextureFaceData;
#elseif arp_display_backend_heaps
typedef TextureFaceData = arpx.impl.heaps.texture.TextureFaceData;
#elseif arp_display_backend_sys
typedef TextureFaceData = arpx.impl.sys.texture.TextureFaceData;
#elseif (arp_display_backend_stub || arp_backend_display)
typedef TextureFaceData = arpx.impl.stub.texture.TextureFaceData;
#end
