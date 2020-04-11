# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Getpocket::Repository do
  let(:config) { double }

  describe '#add'
  describe '#modify'

  describe '#retrieve' do
    let(:fetcher_stub) { double }

    before do
      allow(Getpocket::Operations::Fetcher).to receive(:new).and_return(fetcher_stub)
    end

    shared_examples 'maps entities' do
      it 'returns a collection' do
        expect(result).to be_kind_of(Array)
      end

      it 'returns mapped entities' do
        expect(result.first).to be_kind_of(Getpocket::Article)
      end
    end

    context 'when no page given' do
      subject(:result) { described_class.new(config).retrieve(per_page: 1) }

      include_examples 'maps entities'

      it 'uses retriever operation' do
        expect(fetcher_stub).to receive(:call).with(since: nil, per_page: 1)
        result
      end
    end

    context 'when page number is given' do
      subject(:result) { described_class.new(config).retrieve(since: Time.now, per_page: 1) }

      it 'uses retriever operation' do
        expect(fetcher_stub).to receive(:call).with(since: kind_of(Time), per_page: 1).and_return([])
        result
      end
    end
  end
end
