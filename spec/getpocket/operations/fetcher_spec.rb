# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Getpocket::Operations::Fetcher do
  let(:config) { double(consumer_key: 'key-123', access_token: 'token-123') }
  let(:api_answer) do
    '{"status":1,"list":{"229279689":{"item_id":"229279689",
"resolved_id":"229279689",
"given_url":"http:\/\/www.grantland.com\/blog\/the-triangle\/post\/_\/id\/38347\/ryder-cup-preview",
"given_title":"The Massive Ryder Cup Preview - The Triangle Blog - Grantland",
"favorite":"0",
"status":"0",
"resolved_title":"The Massive Ryder Cup Preview",
"resolved_url":"http:\/\/www.grantland.com\/blog\/the-triangle\/post\/_\/id\/38347\/ryder-cup-preview",
"excerpt":"The list of things I love about the Ryder Cup is so long that it could fill a (tedious) novel, and golf fans can probably guess most of them.",
"is_article":"1",
"has_video":"1",
"has_image":"1",
"word_count":"3197",
"images":{"1":{"item_id":"229279689","image_id":"1",
    "src":"http:\/\/a.espncdn.com\/combiner\/i?img=\/photo\/2012\/0927\/grant_g_ryder_cr_640.jpg&w=640&h=360",
    "width":"0","height":"0","credit":"Jamie Squire\/Getty Images","caption":""}},
"videos":{"1":{"item_id":"229279689","video_id":"1",
    "src":"http:\/\/www.youtube.com\/v\/Er34PbFkVGk?version=3&hl=en_US&rel=0",
    "width":"420","height":"315","type":"1","vid":"Er34PbFkVGk"}}}}}'
  end

  describe '#call' do
    before do
      stub_request(:post, 'https://getpocket.com/v3/get').to_return(body: api_answer)
    end

    subject(:result) { described_class.new(config).call(offset: 0, per_page: 10) }

    it 'makes a request to the api' do
      result
      expect(
        a_request(:post, 'https://getpocket.com/v3/get')
      ).to have_been_made.once
    end

    it 'returns fetched result' do
      expect(result.first.keys).to all(be_kind_of(Symbol))
    end

    it 'does not include `since` parameter in the request' do
      result
      expect(
        a_request(:post, 'https://getpocket.com/v3/get').with do |req|
          params = JSON.parse(req.body)
          expect(params).to_not include('since')
        end
      ).to have_been_made
    end

    it 'uses per_page parameter in the request' do
      result
      expect(
        a_request(:post, 'https://getpocket.com/v3/get').with do |req|
          params = JSON.parse(req.body)
          expect(params).to include('count')
        end
      ).to have_been_made
    end

    context 'when no articles in the answer' do
      let(:api_answer) do
        '{"status":1,"list":[]}'
      end

      it 'returns an empty array' do
        expect(result).to be_empty
      end
    end
  end
end
