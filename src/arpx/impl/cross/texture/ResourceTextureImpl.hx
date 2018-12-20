package arpx.impl.cross.texture;

#if arp_display_backend_flash
typedef ResourceTextureImpl = arpx.impl.flash.texture.ResourceTextureImpl;
#elseif arp_display_backend_heaps
typedef ResourceTextureImpl = arpx.impl.heaps.texture.ResourceTextureImpl;
#elseif arp_display_backend_sys
typedef ResourceTextureImpl = arpx.impl.sys.texture.ResourceTextureImpl;
#elseif (arp_display_backend_stub || arp_backend_display)
typedef ResourceTextureImpl = arpx.impl.stub.texture.ResourceTextureImpl;
#end
