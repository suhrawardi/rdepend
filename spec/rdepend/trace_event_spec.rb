require File.dirname(__FILE__) + '/../spec_helper'

describe Rdepend::TraceEvent do
  subject { Rdepend::TraceEvent.new(:return, 'String', :size) }

  describe 'initialize' do
    its(:event_type) { is_expected.to eq(:return) }
    its(:defined_class) { is_expected.to eq('String') }
    its(:method_id) { is_expected.to eq(:size) }
  end

  describe 'event_class' do
    its(:event_class) { is_expected.to eq(Rdepend::Event::Return) }
  end
end
