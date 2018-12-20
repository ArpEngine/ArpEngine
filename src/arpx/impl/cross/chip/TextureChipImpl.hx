package arpx.impl.cross.chip;

#if arp_display_backend_flash
typedef TextureChipImpl = arpx.impl.flash.chip.TextureChipImpl;
#elseif arp_display_backend_heaps
typedef TextureChipImpl = arpx.impl.heaps.chip.TextureChipImpl;
#elseif arp_display_backend_sys
typedef TextureChipImpl = arpx.impl.sys.chip.TextureChipImpl;
#elseif (arp_display_backend_stub || arp_backend_display)
typedef TextureChipImpl = arpx.impl.stub.chip.TextureChipImpl;
#end
