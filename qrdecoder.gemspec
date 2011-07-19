lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'qrdecoder/version'

Gem::Specification.new do |s|
  s.version = QRDecoder::VERSION
  s.platform = Gem::Platform::RUBY

  s.name = "qrdecoder"
  s.summary = %Q{Wrapper around the C++ zxing library for decoding QR Codes}
  s.description = %Q{This Gem is a wrapper around an useful open-source library for decoding QR
  Codes, a two-dimensional bar code format popular in Japan created by the Denso-Wave Corporation in 1994.}
  s.email = ['josh@joshuadavey.com', 'dave@davelyon.net']
  s.authors = ['Joshua Davey', 'Dave Lyon']
  s.date     = '2011-07-17'

  s.extensions = ["ext/qrdecoder_ext/extconf.rb"]

  s.extra_rdoc_files = ["README.rdoc"]
  s.files = Dir.glob("{bin,lib,ext}/**/*") + %w(README.rdoc) - Dir.glob("{bin,lib,ext}/**/*.bundle")

  s.require_path = 'lib'
  s.required_rubygems_version = ">= 1.3.6"
  s.add_development_dependency "rspec", "~> 2.6.0"
  s.add_development_dependency "rake-compiler", "~> 0.7.5"

  s.test_files = Dir.glob("spec/**/*_spec.rb") + %w{spec/spec_helper.rb}
end
