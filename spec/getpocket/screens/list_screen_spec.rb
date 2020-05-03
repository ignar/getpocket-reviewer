# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Getpocket::Screens::ListScreen do
  describe '#[]' do
    it 'returns self' do
      # TODO: use entity
      expect(subject[access_token: 'token', cursor_position: 0, per_page: 0]).to be(subject)
    end

    it 'sets a state' do
      expect { subject[access_token: 'access-token', cursor_position: 0, per_page: 0, first_element: :a] }.to \
        change(subject, :access_token).from(nil).to('access-token')
        .and(change(subject, :cursor_position).from(nil).to(0))
        .and(change(subject, :per_page).from(nil).to(0))
        .and(change(subject, :first_element).from(nil).to(:a))
    end
  end

  describe '#process' do
    subject(:result) do
      described_class.new[
        access_token: access_token,
        cursor_position: 1,
        per_page: 10
      ].process(reader)
    end

    before do
      Application.stub('getpocket.operations.display', display)
      Application.stub('getpocket.local_repository', local_repository)
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
    let(:local_repository) { double('LocalRepository', retrieve: [1, 2, 3]) }

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
        expect(display).to receive(:call).once
        result
      end
    end

    context 'when pressed down' do
      let(:pressed_key) { "\e[B" }

      context 'when it is the last line'
      context 'when it is not the last line' do
        it 'returns the new state with updated cursor position' do
          expect(result.cursor_position).to eq(2)
        end
      end
    end

    context 'when pressed up' do
      let(:pressed_key) { "\e[A" }

      context 'when it is the first line'

      context 'when it is not the first line' do
        it 'returns the new state with updated cursor position' do
          expect(result.cursor_position).to eq(0)
        end
      end
    end
  end
end
