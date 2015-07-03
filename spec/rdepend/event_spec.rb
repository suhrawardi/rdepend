require File.dirname(__FILE__) + '/../spec_helper'

describe Rdepend::Event do
  describe '.initialize' do
    context 'a :call event' do
      let(:event) { double('event', event: :call) }

      it 'instantiates a Call event' do
        expect(Rdepend::Event::Call).to receive(:new)
        Rdepend::Event.new(event)
      end
    end

    context 'a :return event' do
      let(:event) { double('event', event: :return) }

      it 'instantiates a Return event' do
        expect(Rdepend::Event::Return).to receive(:new)
        Rdepend::Event.new(event)
      end
    end
  end
end
