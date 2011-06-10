require 'qrdecoder/version'
require 'qrdecoder/qrdecoder_ext'

module QRDecoder
  def self.decode(path)
    decode_from_path(File.realpath(path))
  end
end
