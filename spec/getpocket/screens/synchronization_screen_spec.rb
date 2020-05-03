# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Getpocket::Screens::SynchronizationScreen do
  describe '#process' do
    subject(:result) { described_class.new[access_token: access_token].process }

    let(:display) { double(call: true) }
    let(:access_token) { double }
    let(:synchronizer) { double(call: true) }

    before do
      Application.stub('getpocket.operations.display', display)
      Application.stub('getpocket.articles_synchronizer', synchronizer)
    end

    it 'returns ListScreen' do
      expect(result).to be_kind_of(Getpocket::Screens::ListScreen)
    end

    it 'renders expected screens' do
      expect(display).to(receive(:call).with([
        instance_of(Getpocket::Ui::MainFrame),
        instance_of(Getpocket::Ui::SynchronizationMessage),
      ]))
      result
    end

    it 'initiates entries synchronization from Getpocket' do
      expect(synchronizer).to receive(:call).with(access_token)
      result
    end
  end
end
