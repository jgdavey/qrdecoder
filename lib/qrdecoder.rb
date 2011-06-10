require 'qrdecoder/version'
require 'qrdecoder/qrdecoder_ext'

require 'uri'

module QRDecoder

  # Decode the QR Code image at +path+
  #
  # +path+ can be the path to an image, an instance of Pathname, or an instance
  # of File
  #
  # Returns the string of text encoded in the image.
  #
  # === Usage
  #
  #   string = QRDecoder.decode("myqrcode.png")
  def self.decode(path)
    decode_from_path absolute_path(path)
  end

  # Decode the QR Code image at +path+ and return a URI instance
  #
  # Returns a URI object created with the URL encoded in the image, or nil if
  # the encoded text is not a valid URL
  #
  # === Usage
  #
  # If you need a URI object, use +decode_url+:
  #
  #   uri = QRDecoder.decode_url("qrcode_url.png")
  #
  # If you want a properly formatted, normalized URL, without trailing spaces,
  # etc., you can use +decode_url+ and immediately convert it back to a string:
  #
  #   string = QRDecode.decode_url("qrcode_url.png").normalize.to_s
  def self.decode_url(path)
    URI.parse decode(path)
  rescue URI::InvalidURIError
    nil
  end

  private
  def self.absolute_path(path)
    path.respond_to?(:path) ? path.path : File.expand_path(path.to_s)
  end
end
