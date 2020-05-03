# frozen_string_literal: true
require 'spec_helper'

RSpec.describe(Getpocket::Screens::AuthenticationScreen) do
  describe '#[]' do
    it 'returns self' do
      expect(subject[request_token: 'request-token']).to(be(subject))
    end

    it 'sets requst_token' do
      expect { subject[request_token: 'request-token'] }.to(
        change(subject, :request_token).from(nil).to('request-token')
      )
    end
  end

  describe '#process' do
    subject(:result) { described_class.new[request_token: request_token].process }

    let(:request_token) { double(request_token: '', redirect_url: '') }
    let(:display) { double }

    before do
      Application.stub('getpocket.operations.display', display)
    end

    it 'renders expected screens' do
      expect(display).to(receive(:call).with([
        instance_of(Getpocket::Ui::MainFrame),
        instance_of(Getpocket::Ui::Authentication),
      ]))
      result
    end
  end
end
