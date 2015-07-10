require File.dirname(__FILE__) + '/../spec_helper'

describe Rdepend do
  describe '#with_trace' do
    let(:block) { ->() { return } }

    it 'delegates to the correct method' do
      expect(Rdepend::Trace).to receive(:exec).and_yield
      Rdepend.with_trace(&block)
    end
  end

  describe '#trace' do
    it 'delegates to the correct method' do
      expect(Rdepend::Trace).to receive(:init)
      Rdepend.trace
    end
  end
end
