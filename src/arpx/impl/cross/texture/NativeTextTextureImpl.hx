package arpx.impl.cross.texture;

#if arp_display_backend_flash
typedef NativeTextTextureImpl = arpx.impl.flash.texture.NativeTextTextureImpl;
#elseif arp_display_backend_heaps
typedef NativeTextTextureImpl = arpx.impl.heaps.texture.NativeTextTextureImpl;
#elseif arp_display_backend_sys
typedef NativeTextTextureImpl = arpx.impl.sys.texture.NativeTextTextureImpl;
#elseif (arp_display_backend_stub || arp_backend_display)
typedef NativeTextTextureImpl = arpx.impl.stub.texture.NativeTextTextureImpl;
#end
