require File.dirname(__FILE__) + '/../../spec_helper'

describe Rdepend::Event::Abstract do
  describe '.initialize' do
    it 'is an abstract class' do
      expect { Rdepend::Event::Abstract.new }.to raise_error(NoMethodError)
    end
  end

  describe 'default values' do
    before do
      class Rdepend::Event::Bogus < Rdepend::Event::Abstract
        def initialize; end
      end
    end

    subject { Rdepend::Event::Bogus.new }

    its(:called_from) { is_expected.to be_nil }
    its(:klass) { is_expected.to be_empty }
    its(:method) { is_expected.to be_empty }
    its(:name) { is_expected.to be_empty }
    its(:event_type) { is_expected.to eq(:bogus) }
  end
end
