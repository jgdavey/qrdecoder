require "mkmf"
require "date"

def exit_failure(msg)
  Logging::message msg
  message msg+"\n"
  exit(1)
end

# C++ flags
cppflags = ENV["CPPFLAGS"] || $CPPFLAGS
$CPPFLAGS   = cppflags.to_s + " " + `Magick-config --cppflags`.chomp

headers = %w{stdio.h stdlib.h math.h time.h}
headers << "stdint.h" if have_header("stdint.h")
headers << "sys/types.h" if have_header("sys/types.h")


if have_header("wand/MagickWand.h")
   headers << "wand/MagickWand.h"
else
   exit_failure "\nCan't install. Can't find MagickWand.h."
end


ldflags = ENV["LDFLAGS"] || $LDFLAGS

ldflags << " " + `Magick-config --ldflags`.chomp
ldflags << " " + `Magick++-config --ldflags`.chomp

$LDFLAGS = ldflags

core_lib = ldflags.match(/-l(MagickCore(-Q\d\d)?)/)[1]
plus_lib = ldflags.match(/-l(Magick\+\+(-Q\d\d)?)/)[1]

unless have_library(core_lib, "InitializeMagick", headers) && have_library(plus_lib, "InitializeMagick", headers)
  exit_failure "Can't find the ImageMagick library (#{lib}) or one of the dependent libraries. " +
        "Check the mkmf.log file for more detailed information.\n"
end

have_library("jpeg")
have_library("zxing")

have_func("snprintf", headers)

have_struct_member("Image", "type", headers)
have_type("MagickFunction", headers)
have_type("ImageLayerMethod", headers)

$defs = []

create_makefile("qrdecoder/qrdecoder_ext")
