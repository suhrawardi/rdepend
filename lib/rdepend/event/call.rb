module Rdepend
  class Event
    class Call < Rdepend::Event::Abstract
#      extend Forwardable
#      def_delegators :@name, :name, :klass, :method # verplaatsen naar de struct !

      def initialize(event, called_from)
        @event = event
        @called_from = called_from
#        @name = initialize_event_name(event)
#        update_state
        update_graph
      end

#      def called_from
#        Rdepend::State.instance.fetch(@from)
#      end

      private

#      def key
#        @event.key
#      end

      def update_graph
        if @called_from
          Graph::Creator.instance.add_node_with_edge(@called_from, @event)
        else
          Graph::Creator.instance.add_node(@event)
        end
      end

#      def update_state
#        State.instance.push(self)
#      end
    end
  end
end
