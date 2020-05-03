# frozen_string_literal: true
require 'spec_helper'

RSpec.describe(Getpocket::Operations::Authenticate) do
  describe '#call' do
    subject(:result) { described_class.new.call }

    let(:config) { double(consumer_key: 'uyytr', redirect_url: 'ruby-cli:authorizationFinished') }
    let(:request_token) { 'ix78=92c-37sdfh' }
    let(:getpocket_api_url) { 'https://getpocket.com/v3/oauth/request' }

    before do
      stub_request(:post, getpocket_api_url)
        .to_return(body: { code: request_token }.to_json)
    end

    context 'valid consumer key' do
      it 'makes a request to the API' do
        result
        expect(a_request(:post, getpocket_api_url))
          .to(have_been_made.once)
      end

      it 'returns RequestToken object' do
        expect(result).to(be_kind_of(Getpocket::RequestToken))
      end
    end

    context 'invalid consumer key'
  end
end
