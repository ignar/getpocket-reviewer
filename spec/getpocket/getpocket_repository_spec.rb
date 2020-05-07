# typed: false
# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Getpocket::GetpocketRepository do
  let(:config) { double }

  describe '#add'
  describe '#modify'

  describe '#retrieve' do
    let(:fetcher_stub) { double(call: [fetched_entry]) }
    let(:fetched_entry) do
      {
        item_id: "229279689",
        resolved_id: "229279689",
        given_url: "http:\/\/www.grantland.com\/blog\/the-triangle\/post\/_\/id\/38347\/ryder-cup-preview",
        given_title: "The Massive Ryder Cup Preview - The Triangle Blog - Grantland",
        favorite: "0",
        status: "0",
        resolved_title: "The Massive Ryder Cup Preview",
        resolved_url: "http:\/\/www.grantland.com\/blog\/the-triangle\/post\/_\/id\/38347\/ryder-cup-preview",
        excerpt: "The list of things I love about the Ryder Cup is so long that it could fill a (tedious) novel, and golf fans can probably guess most of them.",
        is_article: "1",
        has_video: "1",
        has_image: "1",
        word_count: "3197",
        images: { "1": { "item_id": "229279689", "image_id": "1",
                         "src": "http:\/\/a.espncdn.com\/combiner\/i?img=\/photo\/2012\/0927\/grant_g_ryder_cr_640.jpg&w=640&h=360",
                         "width": "0", "height": "0", "credit": "Jamie Squire\/Getty Images", "caption": "" } },
        videos: { "1": { "item_id": "229279689", "video_id": "1",
                         "src": "http:\/\/www.youtube.com\/v\/Er34PbFkVGk?version=3&hl=en_US&rel=0",
                         "width": "420", "height": "315", "type": "1", "vid": "Er34PbFkVGk" } },
      }
    end

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

      it 'maps correctly' do
        expect(result.first.given_title).to eq('The Massive Ryder Cup Preview - The Triangle Blog - Grantland')
      end
    end

    context 'when no offset given' do
      subject(:result) { described_class.new[config: config].retrieve(per_page: 1) }

      include_examples 'maps entities'

      it 'uses retriever operation' do
        expect(fetcher_stub).to receive(:call).with(offset: nil, per_page: 1)
        result
      end
    end

    context 'when offset is given' do
      subject(:result) { described_class.new[config: config].retrieve(offset: 10, per_page: 1) }

      include_examples 'maps entities'

      it 'uses retriever operation' do
        expect(fetcher_stub).to receive(:call).with(offset: kind_of(Integer), per_page: 1).and_return([])
        result
      end
    end
  end
end
