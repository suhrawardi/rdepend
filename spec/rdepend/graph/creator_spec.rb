require File.dirname(__FILE__) + '/../../spec_helper'

describe Rdepend::Graph::Creator do
  let(:root) do
    double('root', event_type: :root, name: 'root_node')
  end

  before do
    Rdepend::Graph::Creator.instance.clear
  end

  describe 'is a singleton' do
    it "can't be initialized" do
      expect { Rdepend::Graph::Creator.new }.to raise_error(NoMethodError)
    end

    it "returns it's instance" do
      instance = Rdepend::Graph::Creator.instance
      expect(instance).to be_an_instance_of(Rdepend::Graph::Creator)
    end
  end

  describe '.print' do
    let(:graph) do
      double('graphviz', output: true, name: 'root_node')
    end

    before do
      allow(GraphViz).to receive(:new).and_return(graph)
      Rdepend::Graph::Creator.instance.get_or_create_graph(root)
    end

    it 'prints the graph' do
      expect(graph).to receive(:output).with(svg: 'rdepend/root_node.svg')
      Rdepend::Graph::Creator.instance.print
    end
  end

  describe '.add_node' do
    let(:graph) { double('graph', name: 'GraphName') }
    let(:node) { double('node', name: 'NodeName') }
    let(:root_event) do
      double('event', event_type: :root, name: 'root event',
             klass: 'root', method: :main)
    end

    before do
      allow(GraphViz).to receive(:new).and_return(graph)
      allow(graph).to receive(:get_graph).and_return(nil)
      allow(graph).to receive(:add_graph).and_return(graph)
      allow(graph).to receive(:get_node).and_return(nil)
      allow(graph).to receive(:add_node).and_return(node)
      allow(graph).to receive(:get_or_create_node).and_return(node)
    end

    context 'with the first event' do
      it 'does not create a (sub)graph' do
        expect(Rdepend::Graph::Sub).not_to receive(:create)
        Rdepend::Graph::Creator.instance.add_node(root_event)
      end

      it 'does create the root graph' do
        expect(GraphViz).to receive(:new).and_return(graph)
        Rdepend::Graph::Creator.instance.add_node(root_event)
      end
    end

    context 'with a sequential event' do
      let(:event) do
        double('event', name: 'klass', event_type: :call,
               klass: 'Null', method: 'go_with_the_flow')
      end

      before do
        Rdepend::Graph::Creator.instance.add_node(root_event)
      end

      it 'does create a (sub)graph' do
        args = ['cluster_Null', {label: 'GraphName::Null'}]
        expect(graph).to receive(:add_graph).with(*args).and_return(graph)
        Rdepend::Graph::Creator.instance.add_node(event)
      end

      it 'does not create another root graph' do
        expect(GraphViz).not_to receive(:new)
        Rdepend::Graph::Creator.instance.add_node(event)
      end
    end

    context 'with a :call event and a nameless module' do
      let(:event) do
        double('event', name: 'anonymous', event_type: :call,
               klass: '0x00168', method: :just_a_method)
      end

      before do
        Rdepend::Graph::Creator.instance.add_node(root_event)
      end

      it 'does not create a (sub)graph' do
        expect(Rdepend::Graph::Sub).not_to receive(:create)
        Rdepend::Graph::Creator.instance.add_node(event)
      end

      it 'does not create another root graph' do
        expect(GraphViz).not_to receive(:new)
        Rdepend::Graph::Creator.instance.add_node(event)
      end
    end
  end

  describe '.clear' do
    let(:event) do
      double('event', name: 'null', event_type: :root, klass: '', method: :some)
    end

    before do
      Rdepend::Graph::Creator.instance.add_node(event)
    end

    it 'removes the graph' do
      Rdepend::Graph::Creator.instance.clear
      instance = Rdepend::Graph::Creator.instance
      expect(instance.instance_variable_get(:@graph)).to be_nil
    end
  end
end
