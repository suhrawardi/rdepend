module Rdepend
  module Graph
    class Edge
      def initialize(graph, from, to)
        @graph = graph
        @from = from
        @to = to
      end

      def self.get_or_create(graph, from, to)
        self.new(graph, from, to).get_or_create
      end

      def get_or_create
        @graph.add_edge(@from.node, @to.node)
      end

      private

      def opts
        {}
      end
    end
  end
end
