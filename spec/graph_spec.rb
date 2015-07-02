require File.dirname(__FILE__) + '/spec_helper'

describe Rdepend::Graph do

  describe 'is a singleton' do

    it "can't be initialized" do
      expect { Rdepend::Graph.new }.to raise_error(NoMethodError)
    end

    it "returns it's instance" do
      expect(Rdepend::Graph.instance).to be_an_instance_of(Rdepend::Graph)
    end
  end

  describe '.print' do
    let(:graph) { double('graphviz', output: true) }

    before do
      Rdepend::Graph.instance.clear
      allow(GraphViz).to receive(:new).and_return(graph)
    end

    it 'prints the graph' do
      expect(graph).to receive(:output).with(svg: 'no name.svg')
      Rdepend::Graph.instance.print
    end
  end

  describe '.add_graph' do
  end

  describe '.add_node' do
  end

  describe '.add_edge' do
  end
end
