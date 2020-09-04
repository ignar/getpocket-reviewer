# typed: false
# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Getpocket::Screens::RequestTokenScreen do
  subject(:result) { described_class.new.process }

  let(:request_token) { double }
  let(:authenticate) { double(call: request_token) }
  let(:display) { double }

  before do
    Application.stub('getpocket.operations.authenticate', authenticate)
    Application.stub('getpocket.operations.display', display)
    allow(display).to receive(:call)
  end

  describe '#process' do
    it 'returns AuthenticationScreen' do
      expect(result).to be_kind_of(Getpocket::Screens::AuthenticationScreen)
    end

    it 'renders expected screens' do
      expect(display).to receive(:call).with([
        instance_of(Getpocket::Ui::MainFrame),
        instance_of(Getpocket::Ui::RequestToken),
      ])
      result
    end
  end
end
