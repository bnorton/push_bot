require 'spec_helper'

describe PushBot::Device do
  let(:user_token) { 'user token' }

  subject { described_class.new(user_token, :ios) }

  let(:request) { double(PushBot::Request) }

  before do
    allow(PushBot::Request).to receive(:new).with(:deviceToken).and_return(request)
  end

  describe '#all' do
    let(:all) { subject.all }

    it 'should list all of the' do
      expect(request).to receive(:get).with(:all)

      all
    end
  end

  describe '#add' do
    let(:message) { 'Push Message' }
    let(:options) { { :extra => 'value' } }

    let(:add) { subject.add(options) }

    it 'should send the given attributes' do
      expect(request).to receive(:put).with(nil, hash_including(:token => 'user token', :platform => '0'))

      add
    end

    it 'should send the extra attributes' do
      expect(request).to receive(:put).with(anything, hash_including(:extra => 'value'))

      add
    end

    describe 'when given multiple tokens' do
      let(:user_token) { %w(abc 123) }

      it 'should send the batch request' do
        expect(request).to receive(:put).with(:batch, hash_including(:tokens => %w(abc 123), :platform => '0'))

        add
      end

      it 'should not send the token' do
        expect(request).to receive(:put).with(anything, hash_excluding(:token))

        add
      end
    end
  end

  describe '#info' do
    let(:info) { subject.info }

    it 'should send request the information' do
      expect(request).to receive(:get).with(:one, hash_including(:token => 'user token'))

      info
    end
  end

  describe '#removed' do
    let(:removed) { subject.removed }

    it 'should list the removed devices' do
      expect(PushBot::Request).to receive(:new).with(:feedback).and_return(request)
      expect(request).to receive(:get)

      removed
    end
  end

  describe '#remove' do
    let(:remove) { subject.remove }

    it 'should send request the remove' do
      expect(request).to receive(:put).with(:del, hash_including(:token => 'user token', :platform => '0'))

      remove
    end
  end
end
