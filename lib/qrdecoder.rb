require 'qrdecoder/version'
require 'qrdecoder/qrdecoder_ext'

require 'uri'

module QRDecoder
  def self.decode(path)
    decode_from_path absolute_path(path)
  end

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
