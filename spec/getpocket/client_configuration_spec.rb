# frozen_string_literal: true
require 'spec_helper'

RSpec.describe(Getpocket::Reviewer::ClientConfiguration) do
  subject { described_class.new(consumer_key: 'consumer-key', redirect_url: 'redirect-url') }

  describe '#consumer_key' do
    it { expect(subject).to(respond_to(:consumer_key)) }
  end

  describe '#redirect_url' do
    it { expect(subject).to(respond_to(:redirect_url)) }
  end
end
