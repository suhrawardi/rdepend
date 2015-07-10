require File.dirname(__FILE__) + '/../spec_helper'

describe Rdepend::Event do
  describe '.initialize' do
    context 'a :call event' do
      let(:tp_event) do
        double('tp_call_event', event: :call,
               defined_class: 'Null', method_id: :null_method)
      end

      it 'instantiates a Call event' do
        expect(Rdepend::Event::Call).to receive(:new).
          with(Rdepend::TraceEvent)
        Rdepend::Event.new(tp_event)
      end
    end

    context 'a :root event' do
      let(:tp_event) do
        double('tp_root_event', event: :root,
               defined_class: 'test', method_id: :main)
      end

      it 'instantiates a Return event' do
        expect(Rdepend::Event::Root).to receive(:new).
          with(Rdepend::TraceEvent)
        Rdepend::Event.new(tp_event)
      end
    end

    context 'a :return event' do
      let(:tp_event) do
        double('tp_return_event', event: :return,
               defined_class: 'Null', method_id: :null_method)
      end

      it 'instantiates a Return event' do
        expect(Rdepend::Event::Return).to receive(:new).
          with(Rdepend::TraceEvent)
        Rdepend::Event.new(tp_event)
      end
    end
  end
end
