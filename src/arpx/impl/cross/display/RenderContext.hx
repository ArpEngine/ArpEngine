package arpx.impl.cross.display;

#if arp_display_backend_flash
typedef RenderContext = arpx.impl.flash.display.RenderContext;
#elseif arp_display_backend_heaps
typedef RenderContext = arpx.impl.heaps.display.RenderContext;
#elseif arp_display_backend_sys
typedef RenderContext = arpx.impl.sys.display.RenderContext;
#elseif (arp_display_backend_stub || arp_backend_display)
typedef RenderContext = arpx.impl.stub.display.RenderContext;
#end
