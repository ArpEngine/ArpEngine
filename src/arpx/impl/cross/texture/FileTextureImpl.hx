package arpx.impl.cross.texture;

#if arp_display_backend_flash
typedef FileTextureImpl = arpx.impl.flash.texture.FileTextureImpl;
#elseif arp_display_backend_heaps
typedef FileTextureImpl = arpx.impl.heaps.texture.FileTextureImpl;
#elseif arp_display_backend_sys
typedef FileTextureImpl = arpx.impl.sys.texture.FileTextureImpl;
#elseif (arp_display_backend_stub || arp_backend_display)
typedef FileTextureImpl = arpx.impl.stub.texture.FileTextureImpl;
#end
