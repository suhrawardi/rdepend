require File.dirname(__FILE__) + '/../spec_helper'

describe Rdepend::State do
  let(:initial_event) { double('initial event', name: 'initial_event') }
  let(:existing_event) { double('existing event', name: 'existing_event') }
  let(:new_event) { double('new event', name: 'new_event') }
  let(:expected_event) { double('expected event', name: 'expected_event') }

  describe 'is a singleton' do
    it "can't be initialized" do
      expect { Rdepend::State.new }.to raise_error(NoMethodError)
    end

    it "returns it's instance" do
      expect(Rdepend::State.instance).to be_an_instance_of(Rdepend::State)
    end
  end

  describe '.previous' do
    before do
      Rdepend::State.instance.clear
      Rdepend::State.instance.push(initial_event)
    end

    it 'returns the previous state' do
      Rdepend::State.instance.push(existing_event)
      expect(Rdepend::State.instance.previous).to eq(initial_event)
    end

    it 'returns nil when no previous state exists' do
      expect(Rdepend::State.instance.previous).to be_nil
    end
  end

  describe '.last' do
    before do
      Rdepend::State.instance.clear
    end

    it 'returns the last state' do
      Rdepend::State.instance.push(existing_event)
      expect(Rdepend::State.instance.last).to eq(existing_event)
    end

    it 'returns nil when no last state exists' do
      expect(Rdepend::State.instance.last).to be_nil
    end
  end

  describe '.push' do
    before do
      Rdepend::State.instance.clear
      Rdepend::State.instance.push(initial_event)
    end

    it 'accepts a new state' do
      expect do
        Rdepend::State.instance.push(new_event)
      end.to change(Rdepend::State.instance, :size)
    end
  end

  describe '.pop' do
    before do
      Rdepend::State.instance.clear
      Rdepend::State.instance.push(initial_event)
    end

    it 'accepts a new state' do
      expect do
        Rdepend::State.instance.pop
      end.to change(Rdepend::State.instance, :size).by(-1)
    end
  end

  describe '.pop_if_similar_to' do
    let(:another_expected_event) do
      double('another_expected_event', name: 'expected_event')
    end

    before do
      Rdepend::State.instance.clear
    end

    it 'pops the expected state' do
      Rdepend::State.instance.push(expected_event)
      expect do
        Rdepend::State.instance.pop_if_similar_to(another_expected_event)
      end.to change(Rdepend::State.instance, :size).by(-1)
    end

    it 'does not pop another state' do
      Rdepend::State.instance.push(expected_event)
      expect do
        Rdepend::State.instance.pop_if_similar_to(new_event)
      end.not_to change(Rdepend::State.instance, :size)
    end

    it 'handles an empty list gracefully' do
      expect do
        Rdepend::State.instance.pop_if_similar_to(new_event)
      end.not_to raise_error
    end
  end

  describe '.clear' do
    before do
      Rdepend::State.instance.push(existing_event)
    end

    it 'clears the states' do
      Rdepend::State.instance.clear
      expect(Rdepend::State.instance.size).to eq(0)
    end
  end

  describe '.size' do
    before do
      Rdepend::State.instance.clear
      Rdepend::State.instance.push(existing_event)
    end

    it 'returns the size' do
      expect(Rdepend::State.instance.size).to eq(1)
    end
  end

  describe '.inspect' do
    before do
      Rdepend::State.instance.clear
      Rdepend::State.instance.push(existing_event)
    end

    it 'returns a description' do
      expected_string = '#<Rdepend::State: ["existing_event"]>'
      expect(Rdepend::State.instance.inspect).to eq(expected_string)
    end
  end
end
