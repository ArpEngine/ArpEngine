package arpx.impl.cross.chip;

#if arp_display_backend_flash
typedef NativeTextChipImpl = arpx.impl.flash.chip.NativeTextChipImpl;
#elseif arp_display_backend_heaps
typedef NativeTextChipImpl = arpx.impl.heaps.chip.NativeTextChipImpl;
#elseif arp_display_backend_sys
typedef NativeTextChipImpl = arpx.impl.sys.chip.NativeTextChipImpl;
#elseif (arp_display_backend_stub || arp_backend_display)
typedef NativeTextChipImpl = arpx.impl.stub.chip.NativeTextChipImpl;
#end
