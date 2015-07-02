require File.dirname(__FILE__) + '/../spec_helper'

describe Rdepend::Event::Return do

  describe '.initialize' do

    let(:event) { double('event', event: :return) }

    it 'pops the state' do
      expect {
        Rdepend::Event::Return.new(event)
      }.to change(Rdepend::State.instance, :size).by(-1)
    end
  end
end
