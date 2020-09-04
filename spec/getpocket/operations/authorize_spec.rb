# typed: false
# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Getpocket::Operations::Authorize do
  subject(:result) { described_class.new.call(config) }

  let(:config) { double(consumer_key: 'key-123', request_token: 'token-123', redirect_url: 'http://app.com') }
  let(:answer) { { username: 'User', access_token: 'access-token-123' } }
  let(:getpocket_api_url) { 'https://getpocket.com/v3/oauth/authorize' }

  before do
    stub_request(:post, getpocket_api_url)
      .to_return(body: answer.to_json)
  end

  describe '#call' do
    it 'requests access token and username' do
      result
      expect(a_request(:post, getpocket_api_url))
        .to have_been_made.once
    end
    it 'returns AccessToken' do
      expect(result).to be_kind_of(Getpocket::AccessToken)
    end
  end
end
