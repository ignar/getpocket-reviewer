# typed: false
# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Getpocket::Screens::AccessTokenScreen do
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
    subject(:result) { described_class.new[request_token: 'token'].process(reader) }

    let(:authorize) { double(call: 'access-token') }
    let(:display) { double(call: true) }

    before do
      Application.stub('getpocket.operations.display', display)
      Application.stub('getpocket.operations.authorize', authorize)
    end

    context 'when user presses `returns`' do
      let(:reader) do
        double(
          read_keypress: '\r',
          console: double(keys: { '\r' => :return })
        )
      end

      it 'renders expected screens' do
        expect(display).to receive(:call).with([
          instance_of(Getpocket::Ui::MainFrame),
          instance_of(Getpocket::Ui::AccessToken),
        ])
        result
      end

      it 'returns SynchronizationScreen' do
        expect(result).to be_kind_of(Getpocket::Screens::SynchronizationScreen)
      end

      it 'sets the initial state of the SynchronizationScreen' do
        expect(result.access_token).to eq('access-token')
      end
    end

    context 'when user presses other key' do
      let(:reader) do
        double(
          read_keypress: 'a',
          console: double(keys: { '\r' => :return, 'a' => 'a' })
        )
      end

      it 'returns self' do
        expect(result).to be_kind_of(Getpocket::Screens::AccessTokenScreen)
      end

      it 'does not render anything' do
        expect(authorize).to_not receive(:call)
        result
      end
    end
  end
end
