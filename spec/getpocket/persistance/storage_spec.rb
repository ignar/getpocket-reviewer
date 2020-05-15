# frozen_string_literal: true
# typed: strong

RSpec.describe Getpocket::Persistance::Storage do
  let(:pstore) { double(transaction: true, '[]': {}, all: {}) }

  before do
    allow(PStore).to receive(:new).and_return(pstore)
  end

  describe '.save' do
    let(:article) do
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

    let(:result) { subject.save(article) }

    it 'persists entity' do
      expect(pstore).to receive(:transaction).and_yield
      result
    end
  end

  describe '.all' do
    let(:result) { subject.all }

    it 'returns all locally stored articles' do
      expect(pstore).to receive(:'[]').with(:articles)
      result
    end
  end
end
