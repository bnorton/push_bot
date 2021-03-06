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

  describe '#alias' do
    let(:options) { { :alias => 'john@example.com' } }
    let(:alias_) { subject.alias(options) }

    it 'should send request the remove' do
      expect(PushBot::Request).to receive(:new).with(:alias).and_return(request)
      expect(request).to receive(:put).with(nil, hash_including(:alias => 'john@example.com', :token => 'user token', :platform => '0'))

      alias_
    end
  end

  describe '#info' do
    let(:info) { subject.info }

    it 'should send request the information' do
      expect(request).to receive(:get).with(:one, hash_including(:token => 'user token'))

      info
    end
  end

  describe '#at_location' do
    let(:location) { [37, -122] }
    let(:at_location) { subject.at_location(*location) }

    before do
      allow(PushBot::Request).to receive(:new).with(:geo).and_return(request)
    end

    it 'should send the latitude and longitude' do
      expect(request).to receive(:put).with(nil, hash_including(:lat => 37, :lng => -122))

      at_location
    end

    describe 'when the location is a push bot location' do
      let(:location) { [PushBot::Location.new(37, -122)] }

      it 'should send the latitude and longitude' do
        expect(request).to receive(:put).with(nil, hash_including(:lat => 37, :lng => -122))

        at_location
      end
    end

    describe 'when the location is an array' do
      let(:location) { [[37, -122]] }

      it 'should send the latitude and longitude' do
        expect(request).to receive(:put).with(nil, hash_including(:lat => 37, :lng => -122))

        at_location
      end
    end

    describe 'when the location is an object{#lat,#lng}' do
      let(:location) { [double(:geo, :lat => 37, :lng => -122)] }

      it 'should send the latitude and longitude' do
        expect(request).to receive(:put).with(nil, hash_including(:lat => 37, :lng => -122))

        at_location
      end
    end

    describe 'when the location is an object{#lat,#lon}' do
      let(:location) { [double(:geo, :lat => 37, :lon => -122)] }

      it 'should send the latitude and longitude' do
        expect(request).to receive(:put).with(nil, hash_including(:lat => 37, :lng => -122))

        at_location
      end
    end

    describe 'when the location is an object{#latitude,#longitude}' do
      let(:location) { [double(:geo, :latitude => 37, :longitude => -122)] }

      it 'should send the latitude and longitude' do
        expect(request).to receive(:put).with(nil, hash_including(:lat => 37, :lng => -122))

        at_location
      end
    end

    describe 'when the location does not exist' do
      let(:location) { [1] }

      it 'should have problems' do
        expect {
          at_location
        }.to raise_error(ArgumentError, /latitude and longitude/)
      end
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
