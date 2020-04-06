# frozen_string_literal: true
require 'spec_helper'

RSpec.describe(Getpocket::Screens::ListScreen) do
  describe '#[]' do
    it 'returns self' do
      # TODO: use entity
      expect(subject[access_token: 'token', cursor_position: 0, page: 0]).to(be(subject))
    end

    it 'sets a state' do
      expect { subject[access_token: 'access-token', cursor_position: 0, page: 0] }.to(
        change(subject, :access_token).from(nil).to('access-token')
        .and(change(subject, :cursor_position).from(nil).to(0))
        .and(change(subject, :page).from(nil).to(0))
      )
    end
  end

  describe '#process' do
    subject(:result) do
      described_class.new[
        access_token: access_token,
        cursor_position: 1,
        page: 1
      ].process(reader)
    end

    before do
      Getpocket::Reviewer::Application.start(:connector)
      Getpocket::Reviewer::Application.stub('getpocket.operations.display', display)
      Getpocket::Reviewer::Application.stub('getpocket.operations.articles_fetcher', articles_fetcher)
      allow(display).to receive(:call)
    end

    let(:access_token) { double }

    let(:pressed_key) { '\r' }
    let(:reader) do
      double(
        read_keypress: pressed_key,
        console: double(keys: {
          '\r' => :return,
          "\e[A" => :up,
          "\e[B" => :down,
          "\e[C" => :right,
          "\e[D" => :left,
        })
      )
    end

    let(:display) { double }

    let(:articles_fetcher) do
      Class.new do
        include Singleton

        def prepare(_, _); end
      end
    end

    it 'renders expected screens' do
      expect(display).to(receive(:call).with([
        instance_of(Getpocket::Ui::MainFrame),
        instance_of(Getpocket::Ui::Menu),
        instance_of(Getpocket::Ui::List),
      ]))
      result
    end

    context 'when pressed unknown key' do
      let(:pressed_key) { 'a' }

      it 'renders ones does nothing' do
        expect(display).to(receive(:call).once)
        result
      end
    end

    context 'when pressed down' do
      let(:pressed_key) { "\e[B" }

      it 'returns the new state with updated cursor position' do
        expect(result.cursor_position).to eq(2)
      end
    end

    context 'when pressed up' do
      let(:pressed_key) { "\e[A" }

      it 'returns the new state with updated cursor position' do
        expect(result.cursor_position).to eq(0)
      end
    end

    context 'when pressed left' do
      let(:pressed_key) { "\e[D" }

      it 'returns the new state with updated page number' do
        expect(result.page).to eq(0)
      end
    end

    context 'when pressed right' do
      let(:pressed_key) { "\e[C" }

      it 'returns the new state with updated page number' do
        expect(result.page).to eq(2)
      end
    end
  end
end
