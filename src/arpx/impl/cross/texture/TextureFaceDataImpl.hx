package arpx.impl.cross.texture;

#if arp_display_backend_flash
typedef TextureFaceDataImpl = arpx.impl.flash.texture.TextureFaceDataImpl;
#elseif arp_display_backend_heaps
typedef TextureFaceDataImpl = arpx.impl.heaps.texture.TextureFaceDataImpl;
#elseif arp_display_backend_sys
typedef TextureFaceDataImpl = arpx.impl.sys.texture.TextureFaceDataImpl;
#elseif (arp_display_backend_stub || arp_backend_display)
typedef TextureFaceDataImpl = arpx.impl.stub.texture.TextureFaceDataImpl;
#end
