require File.dirname(__FILE__) + '/../spec_helper'

describe Rdepend::State do
  describe 'is a singleton' do
    it "can't be initialized" do
      expect { Rdepend::State.new }.to raise_error(NoMethodError)
    end

    it "returns it's instance" do
      expect(Rdepend::State.instance).to be_an_instance_of(Rdepend::State)
    end
  end

  describe '.push' do
    before do
      Rdepend::State.instance.clear
      Rdepend::State.instance.push('an initial state')
    end

    it 'accepts a new state' do
      expect do
        Rdepend::State.instance.push('a new state')
      end.to change(Rdepend::State.instance, :size)
    end
  end

  describe '.previous' do
    before do
      Rdepend::State.instance.clear
      Rdepend::State.instance.push('the initial state')
    end

    it 'returns the previous state' do
      Rdepend::State.instance.push('an existing state')
      previous_state = 'the initial state'
      expect(Rdepend::State.instance.previous).to eq(previous_state)
    end

    it 'returns nil when no previous state exists' do
      expect(Rdepend::State.instance.previous).to be_nil
    end
  end

  describe '.pop' do
    before do
      Rdepend::State.instance.clear
      Rdepend::State.instance.push('an initial state')
    end

    it 'accepts a new state' do
      expect do
        Rdepend::State.instance.pop
      end.to change(Rdepend::State.instance, :size)
    end
  end

  describe '.clear' do
    before do
      Rdepend::State.instance.push('an existing state')
    end

    it 'clears the states' do
      Rdepend::State.instance.clear
      expect(Rdepend::State.instance.size).to eq(0)
    end
  end

  describe '.size' do
    before do
      Rdepend::State.instance.push('an existing state')
    end

    it 'returns the size' do
      expect(Rdepend::State.instance.size).to eq(1)
    end
  end
end
