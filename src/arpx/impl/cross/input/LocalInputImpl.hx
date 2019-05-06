package arpx.impl.cross.input;

#if arp_input_backend_flash
typedef LocalInputImpl = arpx.impl.flash.input.LocalInputImpl;
#elseif arp_input_backend_heaps
typedef LocalInputImpl = arpx.impl.heaps.input.LocalInputImpl;
#elseif arp_input_backend_js
typedef LocalInputImpl = arpx.impl.js.input.LocalInputImpl;
#elseif arp_input_backend_sys
typedef LocalInputImpl = arpx.impl.sys.input.LocalInputImpl;
#elseif (arp_input_backend_stub || arp_backend_display)
typedef LocalInputImpl = arpx.impl.stub.input.LocalInputImpl;
#end
