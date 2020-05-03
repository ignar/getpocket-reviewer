# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Getpocket::LocalRepository do
  describe '#save' do
    let(:article) { double('Article') }
    it 'persists the entity' do
      expect(Getpocket::LocalStorage).to receive(:save).with(article)
      subject.save(article)
    end
  end

  describe '#retrieve' do
    subject(:result) { described_class.new.retrieve(first_element: 2, per_page: 10) }

    before do
      allow(Getpocket::LocalStorage).to receive(:all).and_return((1..15).to_a)
    end

    it 'returns indicated amount of element startign from given position' do
      expect(result).to eq((2..12).to_a)
    end
  end

  describe '#previous' do
    before do
      allow(Getpocket::LocalStorage).to receive(:all).and_return((1..5).to_a)
    end

    context 'when it is not the first element' do
      subject(:result) { described_class.new.previous(4) }

      it 'returns previous element from given' do
        expect(result).to eq(3)
      end
    end

    context 'when first element' do
      subject(:result) { described_class.new.previous(1) }

      it 'returns the same element' do
        expect(result).to eq(1)
      end
    end
  end
end
