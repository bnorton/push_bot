require 'spec_helper'

describe PushBot::Request do
  describe "#request" do
    describe "POST" do
      let(:type){:all}
      let(:options){{msg:'foo',platform: '0'}}
      it "Typhoeus::Request should receive #new" do
        expect(Typhoeus::Request).to receive(:new)
        described_class.new(:push).post(type, options)
      end
    end
  end #request
end
