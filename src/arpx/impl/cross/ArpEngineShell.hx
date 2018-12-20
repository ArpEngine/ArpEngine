package arpx.impl.cross;

#if arp_display_backend_flash
typedef ArpEngineShell = arpx.impl.flash.ArpEngineShell;
#elseif arp_display_backend_heaps
typedef ArpEngineShell = arpx.impl.heaps.ArpEngineShell;
#elseif arp_display_backend_sys
typedef ArpEngineShell = arpx.impl.sys.ArpEngineShell;
#elseif (arp_display_backend_stub || arp_backend_display)
typedef ArpEngineShell = arpx.impl.stub.ArpEngineShell;
#end
