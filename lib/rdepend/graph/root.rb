module Rdepend
  module Graph
    class Root
      extend Forwardable
      def_delegators :@graph, :name, :add_graph, :get_graph,
                              :get_node, :add_node, :add_edge

      def initialize(name)
        @graph = GraphViz.new(name, type: :digraph)
      end

      def get_or_create_node(event)
        Node.get_or_create(self, event)
      end

      def print
        Dir.mkdir('rdepend') unless Dir.exist?('rdepend')
        @graph.output(svg: file_name)
      end

      def file_name
        file = File.basename($0, '.rb')
        "rdepend/#{file}.svg"
      end

      def label
        nil
      end
    end
  end
end
