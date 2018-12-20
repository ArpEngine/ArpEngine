package arpx.impl.cross.input.decorators;

#if arp_input_backend_flash
typedef FocusInputImpl = arpx.impl.flash.input.decorators.FocusInputImpl;
#elseif arp_input_backend_heaps
typedef FocusInputImpl = arpx.impl.heaps.input.decorators.FocusInputImpl;
#elseif arp_input_backend_js
typedef FocusInputImpl = arpx.impl.js.input.decorators.FocusInputImpl;
#elseif arp_input_backend_sys
typedef FocusInputImpl = arpx.impl.sys.input.decorators.FocusInputImpl;
#elseif (arp_input_backend_stub || arp_backend_display)
typedef FocusInputImpl = arpx.impl.stub.input.decorators.FocusInputImpl;
#end
