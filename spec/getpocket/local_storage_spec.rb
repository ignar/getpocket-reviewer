# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Getpocket::LocalStorage do
  # TODO: move to helper
  let(:article_1) do
    Getpocket::Article.new(
      item_id: '229279689',
      resolved_id: "229279689",
      given_url: "http:\/\/www.grantland.com\/blog\/the-triangle\/post\/_\/id\/38347\/ryder-cup-preview",
      given_title: "The Massive Ryder Cup Preview - The Triangle Blog - Grantland",
      favorite: "0",
      status: "0",
      resolved_title: "The Massive Ryder Cup Preview",
      resolved_url: "http:\/\/www.grantland.com\/blog\/the-triangle\/post\/_\/id\/38347\/ryder-cup-preview",
      excerpt: "The list of things I love about the Ryder Cup is so long that it could fill a (tedious) novel"\
        ", and golf fans can probably guess most of them.",
      is_article: "1",
      has_video: "1",
      has_image: "1",
      word_count: "3197",
      images: [],
      videos: []
    )
  end

  let(:article_2) do
    Getpocket::Article.new(
      item_id: '229279690',
      resolved_id: "229279690",
      given_url: "http:\/\/www.grantland.com\/blog\/the-triangle\/post\/_\/id\/38347\/ryder-cup-preview",
      given_title: "The Massive Ryder Cup Preview - The Triangle Blog - Grantland",
      favorite: "0",
      status: "0",
      resolved_title: "The Massive Ryder Cup Preview",
      resolved_url: "http:\/\/www.grantland.com\/blog\/the-triangle\/post\/_\/id\/38347\/ryder-cup-preview",
      excerpt: "The list of things I love about the Ryder Cup is so long that it could fill a (tedious) novel"\
        ", and golf fans can probably guess most of them.",
      is_article: "1",
      has_video: "1",
      has_image: "1",
      word_count: "3197",
      images: [],
      videos: []
    )
  end

  before do
    described_class.delete_all
  end

  describe '.save' do
    subject(:result) { described_class.save(article_1) }

    it 'accepts an article object' do
      expect(result).to be_truthy
    end

    it 'does not accept the same article twice' do
      expect(described_class.save(article_1)).to be_truthy
      expect(described_class.save(article_1)).to be_falsey
    end
  end

  describe '#find_all' do
    before do
      described_class.save(article_1)
      described_class.save(article_2)
    end

    context 'when no arguments given' do
      subject(:result) { described_class.find_all }

      it 'returns all articles in the order of saving' do
        expect(result).to contain_exactly(article_1, article_2)
      end
    end

    context 'when offset given' do
      subject(:result) { described_class.find_all(offset: 1) }

      it 'returns with offset' do
        expect(result).to contain_exactly(article_2)
      end
    end

    context 'when limit given' do
      subject(:result) { described_class.find_all(limit: 1) }

      it 'returns with limit' do
        expect(result).to eq([article_1])
      end
    end
  end
end
