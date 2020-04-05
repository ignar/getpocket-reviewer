# frozen_string_literal: true
require 'spec_helper'

RSpec.describe(Getpocket::Reviewer::RequestToken) do
  subject { described_class.new(consumer_key: 'consumer-key', redirect_url: 'redirect-url') }

  describe '#consumer_key' do
    it { expect(subject).to(respond_to(:consumer_key)) }
  end

  describe '#request_token' do
    it { expect(subject).to(respond_to(:request_token)) }

    it 'has a default value' do
      expect(subject.request_token).to(be_empty)
    end

    context 'when value given on initialization' do
      subject { described_class.new(consumer_key: 'consumer-key', redirect_url: 'redirect-url', request_token: 'token') }

      it 'stores given value' do
        described_class.new(consumer_key: 'consumer-key', redirect_url: 'redirect-url')
      end
    end
  end

  describe '#redirect_url' do
    it { expect(subject).to(respond_to(:redirect_url)) }
  end
end
