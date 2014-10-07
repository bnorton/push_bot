require 'spec_helper'

describe PushBot::Push do
  let(:user_token) { 'user token' }

  subject { described_class.new(user_token, :ios) }

  let(:request) { double(PushBot::Request) }

  describe '#notify' do
    let(:message) { 'Push Message' }
    let(:options) { { } }

    let(:notify) { subject.notify(message, options) }

    before do
      allow(PushBot::Request).to receive(:new).with(:push).and_return(request)
    end

    it 'should send the given attributes' do
      expect(request).to receive(:post).with(:one, hash_including(:token => 'user token', :platform => '0', :badge => '0', :sound => ''))

      notify
    end

    it 'should send the extra attributes' do
      expect(request).to receive(:post).with(anything, hash_including(:msg => message))

      notify
    end

    describe 'when the token is not given' do
      let(:user_token) { nil }

      it 'should send the batch request' do
        expect(request).to receive(:post).with(:all, hash_including(:msg => message, :platform => ['0']))

        notify
      end

      it 'should not send the token' do
        expect(request).to receive(:post).with(anything, hash_excluding(:token))

        notify
      end
    end
  end
end
