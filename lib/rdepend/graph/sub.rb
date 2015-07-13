module Rdepend
  module Graph
    class Sub
      extend Forwardable
      def_delegators :@graph, :name, :add_graph, :get_graph,
                              :get_node, :add_node

      def initialize(parent, klass)
        @parent = parent
        @klass = klass
        @graph = get_or_create_graph
      end

      def get_or_create_graph
        @parent.get_graph(name) || @parent.add_graph(name, label: label)
      end

      def get_or_create_node(event)
        Node.get_or_create(self, event)
      end

      def name
        "cluster_#{@klass}"
      end

      def label
        [@parent.label, @klass].compact.join('::')
      end
    end
  end
end
