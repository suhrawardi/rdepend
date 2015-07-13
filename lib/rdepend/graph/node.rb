module Rdepend
  module Graph
    class Node
      attr_reader :node

      def initialize(parent, event)
        @parent = parent
        @event = event
      end

      def self.get_or_create(parent, event)
        self.new(parent, event).get_or_create
      end

      def get_or_create
        get || create
        self
      end

      def name
        @event.name
      end

      private

      def get
        @node = @parent.get_node(@event.name)
      end

      def create
        @node = @parent.add_node(@event.name, label: label, **opts)
      end

      def opts
        {}
      end

      def label
        @event.method
      end
    end
  end
end
