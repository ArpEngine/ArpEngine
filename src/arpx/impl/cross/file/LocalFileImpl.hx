package arpx.impl.cross.file;

#if arp_file_backend_air
typedef LocalFileImpl = arpx.impl.air.file.LocalFileImpl;
#elseif arp_file_backend_flash
typedef LocalFileImpl = arpx.impl.flash.file.LocalFileImpl;
#elseif arp_file_backend_js
typedef LocalFileImpl = arpx.impl.js.file.LocalFileImpl;
#elseif arp_file_backend_sys
typedef LocalFileImpl = arpx.impl.sys.file.LocalFileImpl;
#elseif (arp_file_backend_stub || arp_backend_display)
typedef LocalFileImpl = arpx.impl.stub.file.LocalFileImpl;
#end
