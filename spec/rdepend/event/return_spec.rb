require File.dirname(__FILE__) + '/../../spec_helper'

describe Rdepend::Event::Return do
  describe '.initialize' do
    let(:event) { double('event', event: :return) }

    it 'pops the state' do
      expect do
        Rdepend::Event::Return.new(event)
      end.to change(Rdepend::State.instance, :size).by(-1)
    end
  end

  describe '.event_type' do
    let(:event) do
      double('event', event: :return)
    end

    it 'returns the event type' do
      expect(Rdepend::Event::Return.new(event).event_type).to eq(:return)
    end
  end
end
