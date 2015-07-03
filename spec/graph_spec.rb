require File.dirname(__FILE__) + '/spec_helper'

describe Rdepend::Graph do
  let(:root) { double('root', event_type: :root, name: 'root_node') }

  before do
    Rdepend::Graph.instance.clear
  end

  describe 'is a singleton' do
    it "can't be initialized" do
      expect { Rdepend::Graph.new }.to raise_error(NoMethodError)
    end

    it "returns it's instance" do
      expect(Rdepend::Graph.instance).to be_an_instance_of(Rdepend::Graph)
    end
  end

  describe '.print' do
    let(:graph) do
      double('graphviz', output: true, get_node: nil, name: 'root_node')
    end

    before do
      allow(GraphViz).to receive(:new).and_return(graph)
      Rdepend::Graph.instance.node(root)
    end

    it 'prints the graph' do
      expect(graph).to receive(:output).with(svg: 'root_node.svg')
      Rdepend::Graph.instance.print
    end
  end

  describe '.graph' do
    let(:graph) { double('graphviz', output: true, get_node: nil) }

    context 'with a :root event' do
      let(:event) { double('event', event_type: :root, name: 'root event') }

      before do
        allow(GraphViz).to receive(:new).and_return(graph)
      end

      it 'does create a root graph' do
        expect(GraphViz).to receive(:new)
        Rdepend::Graph.instance.graph(event)
      end
    end

    context 'with a :call event' do
      let(:event) do
        double('event', event_type: :call, klass: '0x00001683')
      end

      it 'does not create a (sub)graph' do
        expect(GraphViz).not_to receive(:new)
        Rdepend::Graph.instance.graph(event)
      end
    end

    context 'with a :call event and a nameless module' do
      let(:event) do
        double('event', event_type: :call, klass: '0x00001683')
      end

      it 'does not create a (sub)graph' do
        expect(GraphViz).not_to receive(:new)
        Rdepend::Graph.instance.graph(event)
      end
    end
  end

  describe '.node' do
    context 'with a :root event' do
    end

    context 'with a :call event' do
    end
  end

  describe '.edge' do
  end

  describe '.clear' do
    before do
      Rdepend::Graph.instance.node(root)
    end

    it 'removes the graph' do
      Rdepend::Graph.instance.clear
      expect(Rdepend::Graph.instance.instance_variable_get(:@graph)).to be_nil
    end
  end
end
