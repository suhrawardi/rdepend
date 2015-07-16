module Rdepend
  module Graph
    class Creator
      include Singleton
      extend Forwardable
      def_delegator :@graph, :print

      def initialize
        @edges = []
      end

      def get_or_create_graph(event)
        if event.event_type == :root
          create_root_graph(event)
        else
          get_or_create_sub_graph(event)
        end
      end

      def add_node(event)
        get_or_create_node(event)
      end

      def add_node_with_edge(from_event, to_event)
        to = get_or_create_node(to_event)
        puts "#{from_event.key} => #{to_event.key}"
        from = get_or_create_node(from_event)
        Edge.get_or_create(@graph, from, to)
      end

      def clear
        @graph = nil
      end

      private

      def get_or_create_node(event)
        get_or_create_graph(event).get_or_create_node(event)
      end

      def create_root_graph(event)
        @graph = Root.new(event.label)
      end

      def get_or_create_sub_graph(event)
        event.klass.split(/::/).inject(@graph) do |graph, klass|
          klass =~ /^0x/ ? graph : Sub.new(graph, klass)
        end
      end
    end
  end
end
