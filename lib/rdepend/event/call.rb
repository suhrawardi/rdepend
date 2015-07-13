module Rdepend
  class Event
    class Call < Rdepend::Event::Abstract
      extend Forwardable
      def_delegators :@name, :name, :klass, :method

      def initialize(event)
        @event = event
        @name = initialize_event_name(event)
        update_state
        update_graph
      end

      def called_from
        Rdepend::State.instance.previous
      end

      private

      def update_graph
        if called_from
          Graph::Creator.instance.add_node_with_edge(called_from, self)
        else
          Graph::Creator.instance.add_node(self)
        end
      end

      def update_state
        State.instance.push(self)
      end
    end
  end
end
