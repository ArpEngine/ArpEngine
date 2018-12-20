package arpx.impl.cross.display;

#if arp_display_backend_flash
typedef DisplayContext = arpx.impl.flash.display.DisplayContext;
#elseif arp_display_backend_heaps
typedef DisplayContext = arpx.impl.heaps.display.DisplayContext;
#elseif arp_display_backend_sys
typedef DisplayContext = arpx.impl.sys.display.DisplayContext;
#elseif (arp_display_backend_stub || arp_backend_display)
typedef DisplayContext = arpx.impl.stub.display.DisplayContext;
#end
