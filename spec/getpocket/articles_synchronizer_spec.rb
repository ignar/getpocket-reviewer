# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Getpocket::ArticlesSynchronizer do
  describe '#call' do
    subject(:result) { described_class.new.call(config) }

    let(:getpocket_repository) { double('GetpocketRepository', '[]': true) }
    let(:local_repository) { double('LocalRepository', save: true) }
    let(:config) { double }
    let(:collection_1) { [1, 2, 3] }
    let(:collection_2) { [] }

    before do
      allow(getpocket_repository).to receive(:retrieve).and_return(collection_1, collection_2)
      Application.stub('getpocket.getpocket_repository', getpocket_repository)
      Application.stub('getpocket.local_repository', local_repository)
    end

    it 'returns all entries from Getpocket as a collection' do
      expect(result).to be_kind_of(Array)
    end

    it 'returns all fetched from repository results as one collection' do
      expect(result).to eq([1, 2, 3])
    end

    it 'updates local storage' do
      expect(local_repository).to receive(:save).exactly(3).times
      result
    end
  end
end
