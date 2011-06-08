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


unless have_library("MagickCore", "InitializeMagick", headers) && have_library("Magick++","InitializeMagick",headers)
  exit_failure "Can't find the ImageMagick library or one of the dependent libraries. " +
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
