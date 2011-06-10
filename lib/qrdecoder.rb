require 'qrdecoder/version'
require 'qrdecoder/qrdecoder_ext'

module QRDecoder
  def self.decode(path)
    decode_from_path(absolute_path(path))
  end

  def self.absolute_path(path)
    path.respond_to?(:path) ? path.path : File.expand_path(path.to_s)
  end
end
