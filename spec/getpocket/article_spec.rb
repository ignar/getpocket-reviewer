# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Getpocket::Article do
  subject do
    described_class.new(
      item_id: '229279689',
      resolved_id: "229279689",
      given_url: "http:\/\/www.grantland.com\/blog\/the-triangle\/post\/_\/id\/38347\/ryder-cup-preview",
      given_title: "The Massive Ryder Cup Preview - The Triangle Blog - Grantland",
      favorite: "0",
      status: "0",
      resolved_title: "The Massive Ryder Cup Preview",
      resolved_url: "http:\/\/www.grantland.com\/blog\/the-triangle\/post\/_\/id\/38347\/ryder-cup-preview",
      excerpt: "The list of things I love about the Ryder Cup is so long that it could fill a (tedious) novel"\
        ", and golf fans can probably guess most of them.",
      is_article: "1",
      has_video: "1",
      has_image: "1",
      word_count: "3197",
      images: [],
      videos: []
    )
  end

  describe 'attributes' do
    subject { described_class }

    it { is_expected.to have_attribute(:item_id) }
    it { is_expected.to have_attribute(:resolved_id) }
    it { is_expected.to have_attribute(:given_url) }
    it { is_expected.to have_attribute(:given_title) }
    it { is_expected.to have_attribute(:favorite) }
    it { is_expected.to have_attribute(:status) }
    it { is_expected.to have_attribute(:resolved_title) }
    it { is_expected.to have_attribute(:resolved_url) }
    it { is_expected.to have_attribute(:excerpt) }
    it { is_expected.to have_attribute(:is_article) }
    it { is_expected.to have_attribute(:has_video) }
    it { is_expected.to have_attribute(:has_image) }
    it { is_expected.to have_attribute(:word_count) }
    it { is_expected.to have_attribute(:images) }
    it { is_expected.to have_attribute(:videos) }
  end
end
