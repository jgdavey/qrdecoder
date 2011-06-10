#include "ruby.h"

#include <iostream>
#include <fstream>
#include <string>
#include <Magick++.h>
#include "MagickBitmapSource.h"
#include <zxing/common/Counted.h>
#include <zxing/qrcode/QRCodeReader.h>
#include <zxing/Binarizer.h>
#include <zxing/MultiFormatReader.h>
#include <zxing/Result.h>
#include <zxing/Reader.h>
#include <zxing/ReaderException.h>
#include <zxing/common/GlobalHistogramBinarizer.h>
#include <zxing/common/HybridBinarizer.h>
#include <exception>
#include <zxing/Exception.h>
#include <zxing/common/IllegalArgumentException.h>
#include <zxing/BinaryBitmap.h>
#include <zxing/DecodeHints.h>
using namespace Magick;
using namespace std;
using namespace zxing;
using namespace zxing::qrcode;


VALUE mQRDecoder;

extern "C"
VALUE _decode_from_path(VALUE klass, VALUE path) {
  VALUE r_str;
  Image image;
  char *filepath = StringValueCStr(path);
  try {
    image.read(filepath);
  } catch (...) {
    rb_raise(rb_eIOError, "unable to read file");
    cerr << "Unable to open image, ignoring" << filepath << endl;
  }
  try {
    Ref<MagickBitmapSource> source(new MagickBitmapSource(image));

    Ref<Binarizer> binarizer(NULL);
    binarizer = new GlobalHistogramBinarizer(source);

    Ref<BinaryBitmap> image(new BinaryBitmap(binarizer));
    Ref<Reader> reader(new MultiFormatReader);
    Ref<Result> result(reader->decode(image));
    const char *str = result->getText()->getText().c_str();
    r_str = rb_str_new2( str );
  } catch (zxing::Exception& e) {
    r_str = Qnil;
  }

  return r_str;
}

extern "C"
void Init_qrdecoder_ext()
{
    mQRDecoder = rb_define_module("QRDecoder");
    rb_define_module_function(mQRDecoder, "decode_from_path", (VALUE(*)(...))_decode_from_path, 1);
}
