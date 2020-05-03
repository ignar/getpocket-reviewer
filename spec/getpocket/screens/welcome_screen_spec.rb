# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Getpocket::Screens::WelcomeScreen do
  subject(:result) { described_class.new.process }

  let(:display) { double }

  before do
    Application.stub('getpocket.operations.display', display)
    allow(display).to receive(:call)
  end

  describe '#process' do
    it 'returns RequestTokenScreen' do
      expect(result).to be_kind_of(Getpocket::Screens::RequestTokenScreen)
    end

    it 'renders expected screens' do
      expect(display).to receive(:call).with([
        instance_of(Getpocket::Ui::MainFrame),
        instance_of(Getpocket::Ui::Welcome),
      ])
      result
    end
  end
end
