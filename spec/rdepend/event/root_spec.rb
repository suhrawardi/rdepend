require File.dirname(__FILE__) + '/../../spec_helper'

describe Rdepend::Event::Call do
  let(:root_event) do
    double('root_event', event_type: :root,
           defined_class: 'test', method_id: :main)
  end

  describe '.initialize' do
    it 'adds the state' do
      expect do
        Rdepend::Event::Root.new(root_event)
      end.to change(Rdepend::State.instance, :size).by(1)
    end
  end

  describe '.name' do
    it 'returns the given name' do
      expect(Rdepend::Event::Root.new(root_event).name).to eq('test_main')
    end
  end

  describe '.called_from' do
    it 'returns the name' do
      expect(Rdepend::Event::Root.new(root_event)).to respond_to(:called_from)
    end

    it 'returns nil' do
      expect(Rdepend::Event::Root.new(root_event).called_from).to be_nil
    end
  end

  describe '.event_type' do
    it 'returns the event type' do
      expect(Rdepend::Event::Root.new(root_event).event_type).to eq(:root)
    end
  end
end
