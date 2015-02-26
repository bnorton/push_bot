require 'spec_helper'

describe PushBot::Request do
  describe "#request" do
    describe "POST" do
      let(:id){42}
      let(:secret){'super_secret_key'}
      let(:type){:all}
      let(:options){{msg:'foo',platform: '0'}}
      let(:request_options){{
        method: :post,
        body: JSON.dump(options),
        headers: {
          :'X-PushBots-AppID' => id,
          :'X-PushBots-Secret' => secret,
          :'Content-Type' => :'application/json'
        }
      }}
      before do
        PushBot.configure do |config|
          config.id = id
          config.secret = secret
        end
      end
      it "Typhoeus::Request should receive #new" do
        expect(Typhoeus::Request).to receive(:new).with("https://api.pushbots.com/push/#{type}",request_options)
        described_class.new(:push).post(type, options)
      end
    end
  end #request
end
