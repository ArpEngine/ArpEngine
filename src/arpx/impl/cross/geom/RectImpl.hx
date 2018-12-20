package arpx.impl.cross.geom;

#if arp_display_backend_flash
typedef RectImpl = arpx.impl.flash.geom.RectImpl;
#elseif arp_display_backend_heaps
typedef RectImpl = arpx.impl.heaps.geom.RectImpl;
#elseif arp_display_backend_sys
typedef RectImpl = arpx.impl.sys.geom.RectImpl;
#elseif (arp_display_backend_stub || arp_backend_display)
typedef RectImpl = arpx.impl.stub.geom.RectImpl;
#end
