module Rdepend
  class Graph
    include Singleton

    def initialize
      @edges = []
    end

    def graph(event)
      create_root_graph(event) || sub_graph(event)
    end

    def node(event)
      graph(event).get_node(event) || add_node(event)
    end

    def edge(event)
    end

    def print
      @graph.output(svg: "#{@graph.name}.svg")
    end

    def clear
      @graph = nil
    end

    private

    def create_root_graph(event)
      return unless event.event_type == :root
      @graph = GraphViz.new(@name, type: :digraph)
    end

    def sub_graph(event)
      event.klass.split(/::/).inject(@graph) do |graph, klass|
        create_sub_graph(graph, klass)
      end
    end

    def create_sub_graph(graph, klass)
      return graph if klass =~ /^0x/
      sub_graph = graph.get_graph("cluster#{klass}")
      #color = graph[:color].output.gsub('"', '') rescue nil
      name = [(sub_graph.name rescue ''), klass].join('::')
      graph.add_graph("cluster#{klass}", label: name)
    end

    def add_node(event)
    end
  end
end
