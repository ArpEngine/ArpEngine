package arpx.impl.cross.geom;

#if arp_display_backend_flash
typedef PointImpl = arpx.impl.flash.geom.PointImpl;
#elseif arp_display_backend_heaps
typedef PointImpl = arpx.impl.heaps.geom.PointImpl;
#elseif arp_display_backend_sys
typedef PointImpl = arpx.impl.sys.geom.PointImpl;
#elseif (arp_display_backend_stub || arp_backend_display)
typedef PointImpl = arpx.impl.stub.geom.PointImpl;
#end
