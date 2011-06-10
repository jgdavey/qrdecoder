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
      context "and a relative filepath" do
        let(:path) { "spec/data/bacon.png" }
        it { should == "Chunky Bacon!"}
      end
      context "and a relative filepath containing extra dots" do
        let(:path) { "./spec/data/../data/bacon.png" }
        it { should == "Chunky Bacon!"}
      end
    end

    context "with a Pathname object" do
      let(:path) { Pathname.new qrcode_fixture("bacon.png") }
      it { should == "Chunky Bacon!"}
    end

    context "with a File object" do
      let(:path) { File.open qrcode_fixture("bacon.png") }
      it { should == "Chunky Bacon!"}
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

  describe ".decode_url" do
    subject { QRDecoder.decode_url(path) }
    context "with an encoded url" do
      let(:path) { qrcode_fixture("url.png") }
      it { should be_kind_of URI }
      it { subject.to_s.should == "http://davelyon.net" }
    end
    context "with no encoded url" do
      let(:path) { qrcode_fixture("bacon.png") }
      it { should be_nil }
    end
    context "with an unreachable file path" do
      let(:path) { '/foooo_bad_dir/nopath' }
      it "raises an error" do
        expect { subject }.to raise_error(IOError)
      end
    end
  end
end
