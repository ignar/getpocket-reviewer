# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Getpocket::Repository do
  describe '#add'
  describe '#modify'

  describe '#retrieve' do
    let(:fetcher_stub) { double }
    before do
      allow(Getpocket::Operations::Fetcher).to receive(:new).and_return(fetcher_stub)
    end

    context 'when no page given' do
      subject(:result) { described_class.new.retrieve }

      it 'uses retriever operation' do
        expect(fetcher_stub).to receive(:call).with(since: nil).and_return([])
        result
      end
    end

    context 'when page number is given' do
      subject(:result) { described_class.new.retrieve(since: Time.now) }

      it 'uses retriever operation' do
        expect(fetcher_stub).to receive(:call).with(since: kind_of(Time)).and_return([])
        result
      end
    end
  end
end
