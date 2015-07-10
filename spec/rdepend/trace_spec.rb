require File.dirname(__FILE__) + '/../spec_helper'

describe Rdepend::Trace do
  let(:trace_event) { double('trace event') }
  let(:root_event) { double('root event') }
  let(:trace_point) { double('trace point') }

  before do
    allow(Rdepend::TraceEvent).to receive(:new).and_return(trace_event)
    allow(Rdepend::Event::Root).to receive(:new).and_return(root_event)
    allow(TracePoint).to receive(:new).and_return(trace_point)
    allow(trace_point).to receive(:enable)
  end

  describe '#exec' do
    let(:graph_creator) { double('graph creator') }

    before do
      allow(trace_point).to receive(:disable)
      allow(Rdepend::Graph::Creator).to receive(:instance).
        and_return(graph_creator)
      allow(graph_creator).to receive(:print)
    end

    it 'initializes a new trace_event' do
      file = File.basename($0, '.rb')
      expect(Rdepend::TraceEvent).to receive(:new).with(:root, file, :main)
      Rdepend::Trace.exec { nil }
    end

    it 'initializes a new root event' do
      expect(Rdepend::Event::Root).to receive(:new).with(trace_event)
      Rdepend::Trace.exec { nil }
    end

    it 'initializes a new trace_point' do
      expect(TracePoint).to receive(:new).with(:call, :return)
      Rdepend::Trace.exec { nil }
    end

    it 'enables the trace' do
      expect(trace_point).to receive(:enable)
      Rdepend::Trace.exec { nil }
    end

    it 'disables the trace' do
      expect(trace_point).to receive(:disable)
      Rdepend::Trace.exec { nil }
    end

    it 'prints the graph' do
      expect(Rdepend::Graph::Creator).to receive(:instance).
        and_return(graph_creator)
      expect(graph_creator).to receive(:print)
      Rdepend::Trace.exec { nil }
    end
  end

  describe '#init' do
    before do
      allow(Rdepend::Trace).to receive(:at_exit)
    end

    it 'initializes a new trace_event' do
      file = File.basename($0, '.rb')
      expect(Rdepend::TraceEvent).to receive(:new).with(:root, file, :main)
      Rdepend::Trace.init
    end

    it 'initializes a new root event' do
      expect(Rdepend::Event::Root).to receive(:new).with(trace_event)
      Rdepend::Trace.init
    end

    it 'initializes a new trace_point' do
      expect(TracePoint).to receive(:new).with(:call, :return)
      Rdepend::Trace.init
    end

    it 'enables the trace' do
      expect(trace_point).to receive(:enable)
      Rdepend::Trace.init
    end

    it 'adds an :at_exit callback' do
      expect(Rdepend::Trace).to receive(:at_exit)
      Rdepend::Trace.init
    end
  end
end
