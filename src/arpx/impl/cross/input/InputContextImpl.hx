package arpx.impl.cross.input;

#if arp_input_backend_flash
typedef InputContextImpl = arpx.impl.flash.input.InputContextImpl;
#elseif arp_input_backend_heaps
typedef InputContextImpl = arpx.impl.heaps.input.InputContextImpl;
#elseif arp_input_backend_js
typedef InputContextImpl = arpx.impl.js.input.InputContextImpl;
#elseif arp_input_backend_sys
typedef InputContextImpl = arpx.impl.sys.input.InputContextImpl;
#elseif arp_input_backend_stub
typedef InputContextImpl = arpx.impl.stub.input.InputContextImpl;
#end
