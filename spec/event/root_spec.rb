require File.dirname(__FILE__) + '/../spec_helper'

describe Rdepend::Event::Call do
  let(:name) { 'the name of the root node' }

  describe '.initialize' do

    it 'adds the state' do
      expect {
        Rdepend::Event::Root.new(name)
      }.to change(Rdepend::State.instance, :size).by(1)
    end
  end

  describe '.name' do

    it 'returns the given name' do
      expect(Rdepend::Event::Root.new(name).name).to eq(name)
    end
  end

  describe '.called_from' do

    it 'returns the name' do
      expect(Rdepend::Event::Root.new(name)).to respond_to(:called_from)
    end

    it 'returns nil' do
      expect(Rdepend::Event::Root.new(name).called_from).to be_nil
    end
  end
end
