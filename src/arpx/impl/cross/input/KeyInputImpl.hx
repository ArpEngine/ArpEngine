package arpx.impl.cross.input;

#if arp_input_backend_flash
typedef KeyInputImpl = arpx.impl.flash.input.KeyInputImpl;
#elseif arp_input_backend_heaps
typedef KeyInputImpl = arpx.impl.heaps.input.KeyInputImpl;
#elseif arp_input_backend_js
typedef KeyInputImpl = arpx.impl.js.input.KeyInputImpl;
#elseif arp_input_backend_sys
typedef KeyInputImpl = arpx.impl.sys.input.KeyInputImpl;
#elseif (arp_input_backend_stub || arp_backend_display)
typedef KeyInputImpl = arpx.impl.stub.input.KeyInputImpl;
#end
