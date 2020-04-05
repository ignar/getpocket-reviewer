# frozen_string_literal: true
require 'spec_helper'

RSpec.describe(Getpocket::Operations::Display) do
  subject(:result) { described_class.new.call(views) }

  let(:view_1) { double(:render) }
  let(:view_2) { double(:render) }

  let(:views) do
    [
      view_1,
      view_2,
    ]
  end

  describe '#call' do
    it 'sends render message to each view' do
      expect(view_1).to receive(:render)
      expect(view_2).to receive(:render)
      result
    end
  end
end
