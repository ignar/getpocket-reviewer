# frozen_string_literal: true
require 'spec_helper'

RSpec.describe(Getpocket::Screens::WelcomeScreen) do
  subject(:result) { described_class.new.process }

  describe '#process' do
    it 'returns RequestTokenScreen' do
      expect(result).to(be_kind_of(Getpocket::Screens::RequestTokenScreen))
    end
  end
end
