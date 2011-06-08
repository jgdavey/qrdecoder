require 'spec_helper'

describe QRDecoder do
  describe ".decode" do
    subject { QRDecoder.decode(path) }
    context "with a path to a qrcode image" do
      context "with an encoded phrase" do
        let(:path) { qrcode_fixture("bacon.png") }
        it { should be_kind_of String }
        it { should == "Chunky Bacon!"}
      end
      context "with an encoded url" do
        let(:path) { qrcode_fixture("url.png") }
        it { should == "http://davelyon.net"}
      end
      context "with a large qrcode" do
        let(:path) { qrcode_fixture("big-url.png") }
        it { should == "http://joshuadavey.com"}
      end
    end
    context "with a non-qrcode image" do
      let(:path) { qrcode_fixture("image.png") }
      it { should == nil }
    end
    context "with a 'logoized' qrcode image" do
      let(:path) { qrcode_fixture("logo.jpg") }
      it { subject.strip.should == "http://www.celebrate-originality.jp/" }
    end
    context "with a 'colorized' qrcode image" do
      let(:path) { qrcode_fixture("colors.jpg") }
      it { subject.strip.should == "http://www.havas.com" }
    end
    context "with no arguments" do
      it "raises an error" do
        expect {
          QRDecoder.decode
        }.to raise_error(ArgumentError)
      end
    end
    context "with an invalid file type" do
      it "raises an error" do
        expect {
          QRDecoder.decode(__FILE__)
        }.to raise_error(IOError)
      end
    end
  end
end
