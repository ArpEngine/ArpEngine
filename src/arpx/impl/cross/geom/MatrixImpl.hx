package arpx.impl.cross.geom;

#if arp_display_backend_flash
typedef MatrixImpl = arpx.impl.flash.geom.MatrixImpl;
#elseif arp_display_backend_heaps
typedef MatrixImpl = arpx.impl.heaps.geom.MatrixImpl;
#elseif arp_display_backend_sys
typedef MatrixImpl = arpx.impl.sys.geom.MatrixImpl;
#elseif (arp_display_backend_stub || arp_backend_display)
typedef MatrixImpl = arpx.impl.stub.geom.MatrixImpl;
#end
