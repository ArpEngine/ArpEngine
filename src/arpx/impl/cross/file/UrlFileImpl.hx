package arpx.impl.cross.file;

#if arp_file_backend_flash
typedef UrlFileImpl = arpx.impl.flash.file.UrlFileImpl;
#elseif arp_file_backend_js
typedef UrlFileImpl = arpx.impl.js.file.UrlFileImpl;
#elseif arp_file_backend_sys
typedef UrlFileImpl = arpx.impl.sys.file.UrlFileImpl;
#elseif (arp_file_backend_stub || arp_backend_display)
typedef UrlFileImpl = arpx.impl.stub.file.UrlFileImpl;
#end
